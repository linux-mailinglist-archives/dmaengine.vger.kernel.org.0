Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6D42240E9
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGQQ4Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 12:56:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54418 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgGQQ4P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 12:56:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HGqCCF046351;
        Fri, 17 Jul 2020 16:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fLmOz9fa5tkZPauy96fKApcAsnRfqNPHJeke51o8554=;
 b=bDyrWIp/MIvJTnKUArQMkGBw2wsmKqli2CkEVRFLjZev3bD+y9zMlP9BYEMj+4b5oiHX
 +HmMNV9gOz8wtsBDB5wDD3i65dL2CnNBZslNTjIst4RN+nhT+AR/Wh/M6PQS92415ZCM
 KXhZ69teIkuQqhMgetUSmcpX2HHA6S599UVCx8Z5ZQebCiQXwymmVqLfd2pRFXlbunSE
 GMdzGAgwKfo6P4wcxdR5aa89KkagMEZSayG9UoOlc8LTn7Rw1FcDIbAkmKiuEpsXWRt+
 nZOjqycFxzPOESvy+UEuC/DjZJzwbktCNBuv85M+9B8xL16PLAnvrEBiigK7Y4Y4iMQ7 Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 327s65xpge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 16:56:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HGsEdZ085892;
        Fri, 17 Jul 2020 16:56:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32bbk0qsw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 16:56:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06HGu2Cb002404;
        Fri, 17 Jul 2020 16:56:02 GMT
Received: from [10.74.105.138] (/10.74.105.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 09:56:02 -0700
Subject: Re: [PATCH next v2 0/6] soc: ti: k3-ringacc: updates
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dmaengine@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
References: <20200717132019.20427-1-grygorii.strashko@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <1da72ba7-3ef1-9182-d577-c38d24a79296@oracle.com>
Date:   Fri, 17 Jul 2020 09:55:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717132019.20427-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 mlxscore=100
 adultscore=0 spamscore=100 mlxlogscore=-1000 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=100 priorityscore=1501 lowpriorityscore=0
 spamscore=100 clxscore=1011 bulkscore=0 mlxlogscore=-1000 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170118
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/17/20 6:20 AM, Grygorii Strashko wrote:
> Hi Santosh,
> 
> This series is a set of non critical  updates for The TI K3 AM654x/J721E
> Ring Accelerator driver.
>
Thanks. Will have a look and if all looks good, add it to next.

> Patch 1 - convert bindings to json-schema
> Patches 2,3,5 - code reworking
> Patch 4 - adds new API to request pair of rings k3_ringacc_request_rings_pair()
> Patch 6 - updates K3 UDMA to use new API
> 
> Changes in v2:
> - fixed build warning with patch 6
> - added "Reviewed-by:" and "Acked-by:" tags.
> 
> v1: https://lore.kernel.org/patchwork/cover/1266231/
> 
> Grygorii Strashko (4):
>    dt-bindings: soc: ti: k3-ringacc: convert bindings to json-schema
>    soc: ti: k3-ringacc: add ring's flags to dump
>    soc: ti: k3-ringacc: add request pair of rings api.
>    soc: ti: k3-ringacc: separate soc specific initialization
> 
> Peter Ujfalusi (2):
>    soc: ti: k3-ringacc: Move state tracking variables under a struct
>    dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair
> 
>   .../devicetree/bindings/soc/ti/k3-ringacc.txt |  59 ------
>   .../bindings/soc/ti/k3-ringacc.yaml           | 102 +++++++++
>   drivers/dma/ti/k3-udma-glue.c                 |  42 ++--
>   drivers/dma/ti/k3-udma.c                      |  34 +--
>   drivers/soc/ti/k3-ringacc.c                   | 194 ++++++++++++------
>   include/linux/soc/ti/k3-ringacc.h             |   4 +
>   6 files changed, 261 insertions(+), 174 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
>   create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
> 
