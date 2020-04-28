Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F313E1BC687
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgD1RXo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 13:23:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgD1RXo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Apr 2020 13:23:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SHN2qP036115;
        Tue, 28 Apr 2020 17:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=nYRe3Y8uXuglxFzIR12FaigY66zRmKUyGWDwXjiXdU8=;
 b=cN0Bqq2/+5KRYNGOWfNpmF2uU9/AZOaZnRLCqrEa8dn/0TSCuzme1svSzlLnwkW+8rYK
 jzh/40NuUaLzABl4FTCby60G7PoklecspEg0nyHSr1hxFRfjRyZwPFsZ6tGzrZBTmWee
 MvmtIlZOmgx7CjGwclIUJCMoLxqkrrj5A1oyoVl2EYeGhENkvDUFWwnT/c/bu8D04hVX
 FXm09Uq2SZSxcK+ljsRt4CiKw7kNzfsHCiowYVFK1yRlJ3r4JdBHENHhhQDcWvdxLv18
 Sm7ZZuhoihIJCxCDuZ817tUtdbF8Ml176gGjCnb6k6HPu5udZg67li7HyjLtkdB5fIzE Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30nucg1br4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 17:23:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SHC1EK003111;
        Tue, 28 Apr 2020 17:21:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30mxrt194w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 17:21:34 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SHLUSY017447;
        Tue, 28 Apr 2020 17:21:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 10:21:29 -0700
Date:   Tue, 28 Apr 2020 20:21:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        agross@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom_hidma: Simplify error handling path in
 hidma_probe
Message-ID: <20200428172116.GG2014@kadam>
References: <20200427111043.70218-1-christophe.jaillet@wanadoo.fr>
 <20200428125426.GE2014@kadam>
 <1efa0186-7fbe-9cb5-2719-2d7192f99e27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1efa0186-7fbe-9cb5-2719-2d7192f99e27@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=2 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280137
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I apologize, I wrote my code hurriedly and did no explain the bug well.
I understood what the code is doing, but my fix was missing an if
condition.

On Tue, Apr 28, 2020 at 12:01:15PM -0400, Sinan Kaya wrote:
> On 4/28/2020 8:54 AM, Dan Carpenter wrote:
> >> @@ -897,7 +897,6 @@ static int hidma_probe(struct platform_device *pdev)
> >>  	if (msi)
> >             ^^^
> > This test doesn't work.  It will call free hidma_free_msis() if the
> > hidma_request_msi() call fails.  We should do:
> > 
> > 	if (msi) {
> > 		rc = hidma_request_msi(dmadev, pdev);
> > 		msi = false;

What I meant to say here was:

	if (msi) {
		rc = hidma_request_msi(dmadev, pdev);
		if (rc)
			msi = false;

Otherwise we end up checking freeing the msi in the error handling
code when we did not take it.

Hopefully, that clears things up?

regards,
dan carpenter

