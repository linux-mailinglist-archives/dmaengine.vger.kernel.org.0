Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266B1348969
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 07:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCYGwu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Mar 2021 02:52:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38102 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCYGwX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Mar 2021 02:52:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P6pI1M070976;
        Thu, 25 Mar 2021 06:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xYEedHVl2FgrUCFgYsn8RRcwiqu2E3wlLHDq4Q0kzKY=;
 b=YUArDFZKy9Ac1ch62GdSpFaE+TsXkgTmAp1ZiEytaJWMvqqzM+zD2tl9uWKAXkju2+C0
 dkmQjUtVZXNibQMWsQRiDKSREZRVnMLvjrdVZlAIjrbV1HYBjGyp/Ndz3D8N9diXyXP9
 76wpnDJ95SPTlHjBhqG+0A2BteRFhp2p0Xj4xTJuuRbMblemp7T+02AjwsUH7o7xWmSI
 oHgpQGocebEMCGgdn9BbxWFq/7QuuYSUQBWzz84ommhVexcDiXAaNl+1DFOB+9xQfvGm
 GgIkG6KHpcVQhluL7ZLVk/oa7Yg60rkFwjqD6ukhYa5MAJTtKKNJHD2UrD4kriur6kPL AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37d6jbn9t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 06:52:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P6kFZm166229;
        Thu, 25 Mar 2021 06:52:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37dttu9wnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 06:52:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12P6qD0A021545;
        Thu, 25 Mar 2021 06:52:13 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Mar 2021 06:52:12 +0000
Date:   Thu, 25 Mar 2021 09:52:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210325065205.GT1667@kadam>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com>
 <20210324195252.GQ1667@kadam>
 <20210324233525.GS2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324233525.GS2356281@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250049
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250049
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 08:35:25PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 24, 2021 at 10:52:52PM +0300, Dan Carpenter wrote:
> > On Wed, Mar 24, 2021 at 01:52:46PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
> > > 
> > > > Which is just:
> > > > 
> > > > device_initialize()
> > > > dev_set_name()
> > > > 
> > > > ...then the name is set as early as the device is ready to filled in
> > > > with other details. Just checking for dev_set_name() failures does not
> > > > move the api forward in my opinion.
> > > 
> > > This doesn't work either as the release function must be set after
> > > initialize but before dev_set_name(), otherwise we both can't and must
> > > call put_device() after something like this fails.
> > > 
> > > I can't see an option other than bite the bullet and fix things.
> > > 
> > > A static tool to look for these special lifetime rules around the
> > > driver core would be nice.
> > 
> > If y'all are specific enough about what you want, then I can write the
> > check for you.  What I really want is some buggy sample code and the
> > warning you want me to print.  I kind of vaguely know that devm_ life
> > time rules are tricky but I don't know the details.
> 
> This is driver core rules.
> 
> The setup is:
> 
> struct foo_device
> {
>     struct device dev;
> }
> 
> struct foo_device *fdev = kzalloc(sizeo(*fdev), GFP_KERNEL);
> 
> Then in each of these situations:
> 
>   device_initialize(&fdev->dev);
>   // WARNING initialized struct device's must be destroyed with put_device()
>   kfree(fdev); 
> 

This email is perfect!  Exactly what I want.  My one question would be
what happens if we don't call put_device() in this first example?

The laziest thing would be to just add them to check_unwind.c:

	{ "device_initialize", ALLOC,   0, "$" },
	{ "dev_set_name",      ALLOC,   0, "$" },
	{ "device_register",   ALLOC,   0, "$" },
	{ "put_device", RELEASE, 0, "$" },

The check_unwind.c file assumes that every function cleans up after
itself on error.  It doesn't look for the kfree(fdev).  I could make
kfree() the rule if you want.  I tested it on one file to see if it
generated a warning and it does.

net/atm/atm_sysfs.c:167 atm_register_sysfs() warn: '&adev->class_dev' not released on lines: 153,167.

The line 153 is a real bug, but line 167 calls device_del().  The
comments device_del() say "NOTE: this should be called manually _iff_
device_add() was also called manually." which suggests that this is a
different sort of bug...  Should I add device_del() optional release
function?  I have device_unregister() there already.

	{ "device_unregister", RELEASE, 0, "$" },
	{ "device_del", RELEASE, 0, "$" },

Do we care about nesting?

Anyway, I'm going to pull these out of check_unwind.c into their own
file so that I can make the warning messages a bit better.

regards,
dan carpenter

