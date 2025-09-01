<!-- index.cfm -->
<cfset jobs = [
    {id=1, title="Mental Health Support Worker", location="Sydney", description="Provide day-to-day support for individuals with mental health challenges."},
    {id=2, title="Clinical Psychologist", location="Melbourne", description="Offer therapeutic services, assessments, and interventions."},
    {id=3, title="Rehabilitation Coordinator", location="Brisbane", description="Coordinate care plans and reintegration programs for clients."}
]>

<html>
<head>
    <title>Mental Health Employment Portal</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f5f5; padding:20px; }
        h1 { color:#333; }
        .job-card { background:#fff; padding:15px; margin-bottom:15px; border-radius:8px; box-shadow:0 2px 5px rgba(0,0,0,0.1); }
        .job-card h2 { margin:0; font-size:20px; }
        .job-card p { margin:5px 0; }
        .apply-btn { background:#007BFF; color:#fff; padding:10px 15px; border:none; border-radius:5px; cursor:pointer; }
    </style>
</head>
<body>
    <h1>Mental Health Employment Opportunities</h1>

    <cfloop array="#jobs#" index="job">
        <div class="job-card">
            <img src="sickayda.png">
            <h2>#job.title#</h2>
            <p><strong>Location:</strong> #job.location#</p>
            <p>#job.description#</p>
            <form action="apply.cfm" method="post">
                <input type="hidden" name="jobId" value="#job.id#">
                <input type="submit" class="apply-btn" value="Apply Now">
            </form>
        </div>
    </cfloop>
</body>
</html>

<!-- apply.cfm -->
<cfparam name="form.jobId" default="">
<cfif form.jobId neq "">
    <cfset jobApplied = ArrayFind(jobs, function(j) { return j.id EQ Val(form.jobId); })>
</cfif>

<html>
<head>
    <title>Apply for Job</title>
</head>
<body>
    <h1>Job Application</h1>
    <cfif IsDefined("jobApplied") AND jobApplied GT 0>
        <cfset job = jobs[jobApplied]>
        <h2>Applying for: #job.title# (#job.location#)</h2>
        <form action="submitApplication.cfm" method="post">
            <input type="hidden" name="jobId" value="#job.id#">
            <label>Name:</label><br>
            <input type="text" name="applicantName"><br><br>
            <label>Email:</label><br>
            <input type="email" name="applicantEmail"><br><br>
            <label>Why are you suitable for this role?</label><br>
            <textarea name="coverLetter" rows="5" cols="40"></textarea><br><br>
            <input type="submit" value="Submit Application">
        </form>
    <cfelse>
        <p>No job selected. Go back to <a href="index.cfm">job listings</a>.</p>
    </cfif>
</body>
</html>