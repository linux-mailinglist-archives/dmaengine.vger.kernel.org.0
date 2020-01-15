Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F5313CC0F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAOS06 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 13:26:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37032 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgAOS05 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 13:26:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FIN5FU121958;
        Wed, 15 Jan 2020 18:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=F6SQaCFi8PmmmsQylROI5thWFZ79H1A5nXmOx7Fhsqw=;
 b=eq16sBhr1nm2LAd1UoC2Ko1hyhCVTxJGFyyrkdx0g2/3AniqAFOfA2xaW5JZJa7GhOlL
 SjgttsTM7rmQSvWPBch+qegcifOmi15P72fO5zXBuBK3k3i98/fP/S3MLXnM5w1nlamd
 F8GApoOouXEsp1QpiCPTlR7Mxz8Y3BMcYOT+PbfpTI/FwwIM22gvZytazeDIxh8Hf3dG
 a+rUMGoA/TCEbbuG509sLVCn9Dc+8TNwlB5aNI8nAJOVOLR+C+7hBfUH6lbwYZvJ1YPD
 eDWNzm3y8OBkzUG3At4MoHzorh+zc1jWnuFwEO22dqOBGOnen/aMYbul4b0/gDLIqu9B oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xf74sdw4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 18:26:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FIOOOi072681;
        Wed, 15 Jan 2020 18:26:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xj1aq9drw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 18:26:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00FIQdkm008377;
        Wed, 15 Jan 2020 18:26:39 GMT
Received: from dhcp-10-159-239-64.vpn.oracle.com (/10.159.239.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 10:26:38 -0800
Subject: Re: [PATCH v8 02/18] soc: ti: k3: add navss ringacc driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, robh+dt@kernel.org, nm@ti.com,
        ssantosh@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.strashko@ti.com, lokeshvutla@ti.com, t-kristo@ti.com,
        tony@atomide.com, j-keerthy@ti.com, vigneshr@ti.com,
        frowand.list@gmail.com
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
 <20191223110458.30766-3-peter.ujfalusi@ti.com>
 <6d70686b-a94e-18d1-7b33-ff9df7176089@ti.com>
 <900c2f21-22bf-47f9-5c3c-0a3d95a5d645@oracle.com>
 <ea6a87ae-b978-a786-27eb-db99483a82d9@ti.com>
 <f0230e88-bd9b-cd6d-433d-06d507cafcbd@ti.com>
 <9177657a-71c7-7bd0-a981-3ef1f736d4dc@oracle.com>
 <2c933a6c-37c6-3ef6-7c37-ae36e8c49bf7@ti.com>
 <20200115122440.GI2818@vkoul-mobl>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <b1dba0ad-f7d6-607b-87f7-d3ca746d19ea@oracle.com>
Date:   Wed, 15 Jan 2020 10:26:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200115122440.GI2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150141
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 1/15/20 4:24 AM, Vinod Koul wrote:
> On 15-01-20, 11:44, Peter Ujfalusi wrote:
>>

>>> I would prefer driver patches to go via driver tree.
>>
>> Not sure what you mean by 'driver patches'...
>> The series to enable DMA support on TI's K3 platform consists:
>> Patch 1-2: Ring Accelerator _driver_ (drivers/soc/ti/)
>> Patch 3-6: DMAengine core patches to add new features needed for k3-udma
>> Patch 7-11: DMA _driver_ patches for K3 (drivers/dma/ti/)
>>
>> Patch 10 depends on the ringacc and the DMAengine core patches
>> Patch 11 depends on patch 10
>>
>> I kept it as a single series in hope that they will go via one subsystem
>> tree to avoid build dependency issues and will have a good amount of
>> time in linux-next for testing.
>>
>>>> Vinod could also perhaps setup an immutable branch based on v5.5-rc1
>>>> with just the drivers/soc/ti parts applied so you can merge that branch
>>>> in case you end up having to send up anything that conflicts.
>>>>
>>> As suggested on other email to Peter, these DMA engine related patches
>>> should be queued up since they don't have any dependency. Based on
>>> the status of that patchset, will take care of pulling in the driver
>>> patches either for this merge window or early part of next merge window.
>>
>> OK, I'll send the two patch for ringacc as a separate series.
>>
>> Vinod: Would it be possible for you to pick up the DMAengine core
>> patches (patch 3-6)?
>> The UDMA driver patches have hard dependency on DMAengine core and
>> ringacc, not sure how they are going to go in...
> 
> Since they have build dependency, the usual method for this is:
> 
[...]
> 
> 2. Santosh picks up ring driver patches, provides a signed immutable tag
> which I will pull in and apply the rest, i.e., dmaengine updates and new
> dmaengine driver
> 
I have pushed the ring driver changes with an immutable tag and also 
pushed out to next. I will know if it breaks anything in a day.
If all good, will send out the pull request to ARM soc folks.
Since its already late, its not guaranteed that driver will get
picked up for 5.6 but will request and copy you on pull request. Based
on the state of the pull request, I suggest you decide to
pull my tag and rest of the dma patches to your tree so that we
can avoid any breakage in linus's tree. Feel free to add my ack
for rest of the DMA patchset.

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git 
tags/drivers_soc_for_5.6

Let me know if you have any concerns/questions.

Regards,
Santosh
