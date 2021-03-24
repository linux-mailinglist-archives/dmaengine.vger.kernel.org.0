Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C2348296
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 21:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhCXUIj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 16:08:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43492 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbhCXUIL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Mar 2021 16:08:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OK3Y8x013525;
        Wed, 24 Mar 2021 20:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tNoAbAV97+bdic8XgX154LC/3QmVjOXRfbOgooewDP0=;
 b=WmDWKDsNSnpTKdCERQB24I29VfCgq2PyTeLIy3VX9pKxouH0Ff9Gaah0Xiid2czBI7KQ
 p0hy0ZPL+N2rrOb+R3+rJ5nUUlRfV69RSKsiHVe11bWghTVDg7t8bnDPqEbgRxExucvz
 hDyfQY4rjaXu13/zUOjtCEu07jI6v5kUqwa7k6vN5AYmhaYbg3cxNfkYn8jIsg2IFVTJ
 igDKGvgEDMxarDUvFs8F/B1PWUomXsH+AlllrhdnXjxlMULIlX4STA+lvnixygnEeobw
 7QBHqElRp7lMR+I5RREOA2rZXj66Au7T5OG5aDDs/AB30il63QTAhvVOgqq/2v5a10gx mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37d90mm3p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 20:08:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OK0FfB148354;
        Wed, 24 Mar 2021 20:08:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 37dtttssk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 20:08:05 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12OK84Y0022615;
        Wed, 24 Mar 2021 20:08:04 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Mar 2021 20:08:03 +0000
Date:   Wed, 24 Mar 2021 23:07:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210324200757.GS1667@kadam>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240146
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240146
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
> check after-the-fact.
> 
> That check is broken if the device was not zeroed on allocate.

If it's not zeroed on alloc then you'd probably run into problems much
earlier.  For example, the dev->init_name chunk would probably crash.

	if (dev->init_name) {
		dev_set_name(dev, "%s", dev->init_name);
		dev->init_name = NULL;
	}

regards,
dan carpenter
