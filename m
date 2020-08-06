Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764FF23E005
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHFR6w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 13:58:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50140 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgHFR6v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 13:58:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 076HqMx9104451;
        Thu, 6 Aug 2020 17:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GWGjS1okergUbUW1f9Q9NaiNB9H9selvvFJ3V+2VHMM=;
 b=I33yC6oSful38sp4NtJLagmNfQV7JDBMd+pei8BruFXnjxz+1VmgzeyAxtdgnh2nJCnc
 x7ix7+R6u3Ox38n4EBAul91XFP4gzq/TlDw5lJ3gOzEr17XYsSBIVrOz0DLoJgHjkWgR
 TZeDBJ4dDaFbyTqT2q8sJLXdAx+U1sk6b/zfHWX05NfBVtSCgceBNNdCW4oIf7r5GXXt
 h+k3V+X7ueBkiM5usoTcMQHpSIzKOHSXfpmQBaIoj+ssDXreQ8dkHgspjptjA+rWk/tt
 SikPnCoqjIOafVW+dxP7z8AggVQrz3ciZ5MrQ2chDiQFNGBQskOwaNCE96z3Zq8IPXK6 Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32r6ep4gv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 06 Aug 2020 17:58:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 076HrP7g168276;
        Thu, 6 Aug 2020 17:58:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32qy8nu4r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Aug 2020 17:58:38 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 076Hwab6013255;
        Thu, 6 Aug 2020 17:58:36 GMT
Received: from [10.74.109.129] (/10.74.109.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Aug 2020 10:58:36 -0700
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Fix parameters for rx ring
 pair request
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20200805112746.15475-1-peter.ujfalusi@ti.com>
 <20200805113237.GX12965@vkoul-mobl>
 <3eea63fe-88f5-d6b6-433a-bb15495a839d@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <83ffe78c-3c3b-a1a3-ae17-90a0a1f4da93@oracle.com>
Date:   Thu, 6 Aug 2020 10:58:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3eea63fe-88f5-d6b6-433a-bb15495a839d@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9705 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9705 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060119
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 8/5/20 6:17 AM, Grygorii Strashko wrote:
> 
> 
> On 05/08/2020 14:32, Vinod Koul wrote:
>> On 05-08-20, 14:27, Peter Ujfalusi wrote:
>>> The original commit mixed up the forward and completion ring IDs for the
>>> rx flow configuration.
>>
>> Acked-By: Vinod Koul <vkoul@kernel.org>
>>
>>>
>>> Fixes: 4927b1ab2047 ("dmaengine: ti: k3-udma: Switch to 
>>> k3_ringacc_request_rings_pair")
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>> Hi Santosh, Vinod,
>>>
>>> the offending patch was queued via ti SoC tree.
>>> Santosh, can you pick up this fix also?
> 
> Thank you Peter for catching this - it's valid issue.
> but I'd like to note that issue was discovered with private code and
> nothing is broken in Master.
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
Will queue this up for next merge window.

regards,
Santosh
