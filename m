Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A79D137F
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 18:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfJIQDG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 12:03:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33332 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbfJIQDG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 12:03:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99Fj0MG178749;
        Wed, 9 Oct 2019 16:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=5eyqqcNyRkIYJ/KfstQRnTPLVlNRh+PVIx0mtGqGQzI=;
 b=WycN9nMEm1Z1hwXQ6EnSR9nzH8nWxZAiSQQX0AJ/m1db544ssaE+cNclh6kS79KwtPqW
 qkyCY4KWmDxR2QHbMeRKRSas2ynmKu4pCpSiDEIs4uh9i3sE3jUTsO8MJhyolRtylsx9
 1n9MnIKyyis6+RkLF18ox55DJgLzUNhl2YWcmiClaqUJoiXpm2VIx5GhE3QsHpcZAuiW
 vSgqjdjeAMa+IZ+p3ceeyOs22az2yH9LqV0e1PUAzPercLk57ONTVESeFfv7Hos5PNMv
 aJRGAHWYW/0KKLFwHHg3a3tYJsncOnlDBsFxVPuKg3Z3jsfNd1hIYe5lQJdL6NHRo90k OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vejkunqy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 16:02:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99FhBiM184467;
        Wed, 9 Oct 2019 16:02:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vhhsmudke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 16:02:55 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x99G2qL5007340;
        Wed, 9 Oct 2019 16:02:53 GMT
Received: from dhcp-10-159-237-174.vpn.oracle.com (/10.159.237.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 16:02:52 +0000
Subject: Re: [PATCH v3 00/14] dmaengine/soc: Add Texas Instruments UDMA
 support
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <c567c1a2-2e74-3809-8e0f-4c2049ba4747@oracle.com>
 <7dd18208-1ca5-c902-dc11-edbd4ded51ed@ti.com>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <5b2d27ca-1a1a-6d17-f5d8-62e7eb76c39b@oracle.com>
Date:   Wed, 9 Oct 2019 09:02:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7dd18208-1ca5-c902-dc11-edbd4ded51ed@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090144
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/8/19 3:09 AM, Peter Ujfalusi wrote:
> Hi Santosh,
> 
> On 04/10/2019 19.35, santosh.shilimkar@oracle.com wrote:
>> On 9/30/19 11:16 PM, Peter Ujfalusi wrote:
>>> Hi,
>>>
>>> Changes since v2
>>> )https://patchwork.kernel.org/project/linux-dmaengine/list/?series=152609&state=*)
>>>
>>> - Based on 5.4-rc1
>>> - Support for Flow only data transfer for the glue layer
>>>
[...]

>> Can you please split this series and post drivers/soc/* bits
>> separately ?  If its ready, I can apply k3-ringacc.c changes.
> 
> I'll wait couple of days for guys to check the series, then I can send
> the split out ringacc patches separately.
> 
Sounds good !!
