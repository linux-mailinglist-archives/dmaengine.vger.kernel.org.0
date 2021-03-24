Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9A348235
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhCXTxW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 15:53:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38348 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbhCXTxH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Mar 2021 15:53:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OJoPTY065097;
        Wed, 24 Mar 2021 19:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MvgbdtlpKQ0rkkOSlD2PKGNUUUe2TfrwJIJRHEpAlJQ=;
 b=u1Fz5TWvMMz5pyxUcVQIKQLFRa888mdtmGI9Y24h15FsYaPd12mNeCGEFKFpds9B1IWM
 gvTD91VAdYBk95hk67++upZTELKdG77m3GMP090sVa6vTxFt2ljPH+niGnBgfyG4kZCg
 bzoIRztQI9hfWS6xZ8Z9vd43wEcxiN2g0XzGg5ItdnVYm/yc7HgJ7FrqfVCEA1gjh0wR
 PPirgMsdQhghQtCiko8e58mtuBwMB2dknAzZ8Mj2RqGh0oOkDAWIYkT5I6jqNHSjTH15
 K2j+zJLuHIfmq6vPg0X0VZjADkyqApsR84hnUlgYoYTnSuIK95t5YLOsb5BO7XOpOE7v fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37d6jbm6mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 19:53:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OJpC5T015005;
        Wed, 24 Mar 2021 19:53:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 37dtmr8s9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 19:53:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12OJr0PL031368;
        Wed, 24 Mar 2021 19:53:00 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Mar 2021 12:52:59 -0700
Date:   Wed, 24 Mar 2021 22:52:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210324195252.GQ1667@kadam>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324165246.GK2356281@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240144
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240144
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 01:52:46PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
> 
> > Which is just:
> > 
> > device_initialize()
> > dev_set_name()
> > 
> > ...then the name is set as early as the device is ready to filled in
> > with other details. Just checking for dev_set_name() failures does not
> > move the api forward in my opinion.
> 
> This doesn't work either as the release function must be set after
> initialize but before dev_set_name(), otherwise we both can't and must
> call put_device() after something like this fails.
> 
> I can't see an option other than bite the bullet and fix things.
> 
> A static tool to look for these special lifetime rules around the
> driver core would be nice.

If y'all are specific enough about what you want, then I can write the
check for you.  What I really want is some buggy sample code and the
warning you want me to print.  I kind of vaguely know that devm_ life
time rules are tricky but I don't know the details.

https://lore.kernel.org/dmaengine/CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com/T/#m18d39df4097b12a9a5bdf51bb86b31cd0c6c0136

The error handling in idxd_setup_interrupts() and
idxd_allocate_wqs/engines/groups() is faulty.

+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = kzalloc_node(sizeof(*engine), GFP_KERNEL, dev_to_node(dev));
+		if (!engine) {
+			rc = -ENOMEM;
+			goto err;

Imagine that kzalloc_node() fails on the first iteration.

+		}
+
+		idxd->engines[i] = engine;
+	}
+
+	return 0;
+
+ err:
+	while (--i)
+		kfree(idxd->engines[i]);

The while loop should be while (i--) or while (--i >= 0).  Otherwise,
--i is -1 so this will loop downwards until it crashes.

regards,
dan carpenter

