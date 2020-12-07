Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704012D1566
	for <lists+dmaengine@lfdr.de>; Mon,  7 Dec 2020 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLGQAx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Dec 2020 11:00:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36826 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGQAx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Dec 2020 11:00:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7FxvtU093883;
        Mon, 7 Dec 2020 15:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QmE5XGfNVDaXSVhroX5djONqdwv6Tyi1JDRvHNNex3w=;
 b=Yia5WQj0S7TbqPriIuRPI0r9m4Vt6szO5adGMLngXA1Ufs3GPEO9R2/7qU1sS7WQ85tB
 c/odCmBOtH0fNTGi6E11SYi6KigSC4JcquTrjVmfVTIF0o5tfQKiESxutGUmjE2DWC/k
 VIK3KjSKvbdd98TOfcm5RTgPi12O/y/Gv3GRQgRJstBCqTLPyIdrpeDPJvnRZAyhLsvT
 l+UOvrh8fdxdkiYFLweqU1l77aUbdRq/Ep+tclp224jdkBme+74yETrRQiiHkSjf2Anl
 eJ4uCwA2PsHUTtHP2kIKFXDV73YoYVyE8BPVDOSuiKmpoX2fcEv0uyBbl3GhQjlx6Qza kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3581mqp1b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Dec 2020 15:59:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7FoaQ6078928;
        Mon, 7 Dec 2020 15:59:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 358kyrdpca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Dec 2020 15:59:57 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B7FxtKi020363;
        Mon, 7 Dec 2020 15:59:55 GMT
Received: from [10.74.109.38] (/10.74.109.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 07:59:55 -0800
Subject: Re: [PATCH v2 00/19] dmaengine/soc: k3-udma: Add support for BCDMA
 and PKTDMA
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, ssantosh@kernel.org
Cc:     nm@ti.com, robh+dt@kernel.org, dan.j.williams@intel.com,
        t-kristo@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
 <20201124170856.GR8403@vkoul-mobl>
 <54416232-31b4-e866-82e9-0e9314528a81@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <a1c9189e-0fd1-80b8-8038-cfe556702e60@oracle.com>
Date:   Mon, 7 Dec 2020 07:59:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <54416232-31b4-e866-82e9-0e9314528a81@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9827 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9827 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070102
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/6/20 11:29 PM, Peter Ujfalusi wrote:
> Hi Santosh,
> 
> On 24/11/2020 19.08, Vinod Koul wrote:
>> On 17-11-20, 12:56, Peter Ujfalusi wrote:
>>> Hi,
>>>
>>> The series have build dependency on ti_sci/soc series (v2):
>>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/20201008115224.1591-1-peter.ujfalusi@ti.com/__;!!GqivPVa7Brio!Pr9DZN6u38NBvBa7_OpAJ8CB00wAw4SW4_hXgqWzeI54kvwXsDfntprA-AK9ItxFmM7BaA$
>>>
>>> Santosh kindly created immutable branch holdinf the series:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_5.11/drivers-soc
>>
>> Santosh, Can I have a signed tag for this please?
> 
> Can you please provide a tag for Vinod?
> 
I already sent out pull request with tag.

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git 
tags/drivers_soc_for_5.11
