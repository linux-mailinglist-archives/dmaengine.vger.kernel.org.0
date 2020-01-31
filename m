Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABC514E811
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2020 06:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbgAaFAr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jan 2020 00:00:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39432 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaFAr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jan 2020 00:00:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V4wWVP195240;
        Fri, 31 Jan 2020 05:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=/QmMO/8yHL9c5HdMAqWBKY6PNXPxSw2tZWrggSZk29o=;
 b=U46FC8Tz/eYPUl4MdqZYB+ya38n2vKFUu2I2b1LsuL4eS6qXU4wTf4TM/AP4v2yLl09R
 3a0YI8CyKimnydmxv5+JnuNM1KWGR/oHf97TVwM1OQBbuCsYA30OTfRMwA1XwU9DUAem
 y0LXbZbg0Ft0TojFBH9EY2kkDik9Bt3mWPBEf7mE7BisWgl2eO0f+okv0SO1ocVM5gBo
 4hP2A1qO4eNdM6DZwoOKDTGFzXVYRanOmKI2ONe9N7psf1So6RqFoa02oiSF1tiLgg9E
 MwRq0QhUzzpI/7aLYcEkZSC84W10lEnHinNkoys40LpKb1+o8wjtx3vy6MragCeRPBze hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xrd3ur3yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:00:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V4wYPi089524;
        Fri, 31 Jan 2020 05:00:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xuheufy9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:00:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00V50gNL021516;
        Fri, 31 Jan 2020 05:00:42 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 21:00:42 -0800
Date:   Fri, 31 Jan 2020 08:00:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dave.jiang@intel.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: break out channel registration
Message-ID: <20200131050036.fqb4ke6phimki4x7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=771
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=834 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310043
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Dave Jiang,

The patch d2fb0a043838: "dmaengine: break out channel registration"
from Jan 21, 2020, leads to the following static checker warning:

	drivers/dma/dmaengine.c:965 __dma_async_device_channel_register()
	error: potential NULL dereference 'tchan'.

drivers/dma/dmaengine.c
   954  static int __dma_async_device_channel_register(struct dma_device *device,
   955                                                 struct dma_chan *chan,
   956                                                 int chan_id)
   957  {
   958          int rc = 0;
   959          int chancnt = device->chancnt;
   960          atomic_t *idr_ref;
   961          struct dma_chan *tchan;
   962  
   963          tchan = list_first_entry_or_null(&device->channels,
                                        ^^^^^^^^
The "or_null" suggests that "tchan" can be NULL

   964                                           struct dma_chan, device_node);
   965          if (tchan->dev) {
                    ^^^^^^^^^^
so this should be "if (tchan && tchan->dev)"?

   966                  idr_ref = tchan->dev->idr_ref;
   967          } else {
   968                  idr_ref = kmalloc(sizeof(*idr_ref), GFP_KERNEL);
   969                  if (!idr_ref)
   970                          return -ENOMEM;
   971                  atomic_set(idr_ref, 0);
   972          }
   973  
   974          chan->local = alloc_percpu(typeof(*chan->local));
   975          if (!chan->local)
   976                  goto err_out;

regards,
dan carpenter
