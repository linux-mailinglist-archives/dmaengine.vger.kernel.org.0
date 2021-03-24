Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5878A34824A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 20:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhCXT6Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 15:58:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbhCXT6L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Mar 2021 15:58:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OJsjvn075827;
        Wed, 24 Mar 2021 19:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KUndlTMo7w3xxYcLIY4WLfP6sXCMBopJHmr0y1Lq/To=;
 b=nCh1C/ODZUWbcFpzGi1AjXyFxx6tXykKSLnSVU5aLqDEfrEk4cS88DZrA+GG3PpMP+NI
 TkX/2Bk1r7QO3j6Tgfz71Fse6O7AnoVZ1G6zJiOHNFBerlLUonPnqPm0z4mnZ0rx3oOQ
 58CPj8a2cMys2PmqU8PsXtAJR2m0j1xXra6jNjpAfWcKg34MObpDOrs+S0UURbo17f0o
 x72kRG9WL61uaHXW6I3oCRr+xXpxkQF23qZX7kH13SUPI4QSjkGDiUnFmIPY1HdcK3Ko
 KzlTkL425cDLOzrbsNOQ4+lCT1KYL2R3vSPKziADS/tjPUPdpiso2PjZCoDnmff/f5jT Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8frc3g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 19:58:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OJstxv005772;
        Wed, 24 Mar 2021 19:58:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37du008t85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 19:58:05 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12OJw4F5014904;
        Wed, 24 Mar 2021 19:58:04 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Mar 2021 12:58:04 -0700
Date:   Wed, 24 Mar 2021 22:57:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210324195757.GR1667@kadam>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com>
 <CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240145
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240145
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 10:01:42AM -0700, Dan Williams wrote:
> On Wed, Mar 24, 2021 at 9:52 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
> >
> > > Which is just:
> > >
> > > device_initialize()
> > > dev_set_name()
> > >
> > > ...then the name is set as early as the device is ready to filled in
> > > with other details. Just checking for dev_set_name() failures does not
> > > move the api forward in my opinion.
> >
> > This doesn't work either as the release function must be set after
> > initialize but before dev_set_name(), otherwise we both can't and must
> > call put_device() after something like this fails.
> 
> Ugh, true.
> 
> >
> > I can't see an option other than bite the bullet and fix things.
> >
> > A static tool to look for these special lifetime rules around the
> > driver core would be nice.
> 
> It would... it would also trip over the fact the core itself fails to
> check for dev_set_name() failures and also relies on !dev_name() as a
 check after-the-fact.

Where can I find the !dev_name() check?

regards,
dan carpenter

