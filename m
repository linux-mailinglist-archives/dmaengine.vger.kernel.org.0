Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21DCD7907
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfJOOsg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:48:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59558 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOOsg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Oct 2019 10:48:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FEiRWZ111813;
        Tue, 15 Oct 2019 14:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=iBvQZB/ymL6R4KRMnoHxP7zNs7BB23dad97HHnYj9Is=;
 b=i7vBn9gzT8bsjv+0cdVDWD0gW4NWPuLALe/5yuh88vTXF02dUNtVtoGvjcGwRVB2tNa+
 KP5tYV8fHga7gcnyhpEoVWusYR81SH3RqgRflolM0P3OHhN4cxnAOrMhdEL36GNxlmG7
 hkZ2qodf3g9HhYkhcNpchMmWp1Xlbae0X9cWTgECfOE4TyMpceUYcjmHllaul8rnyb6b
 6hbnCWKR+ak4d7/RTi2IWwpTqccsw4HUl9LnBaCsvhj1bzPOOi8Ro7Q7JVV8eBTxwqu9
 lHcBa6YHlGe1vlMdIs0H9vv03vJLtYrrQMHKhpuAU6Anthxu4fZRHjQzn75ky4QM7u+D Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vk7fr8eeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 14:47:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FEhnQw102633;
        Tue, 15 Oct 2019 14:47:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vnf7rbfm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 14:47:31 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9FElTeS030428;
        Tue, 15 Oct 2019 14:47:29 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 14:47:28 +0000
Date:   Tue, 15 Oct 2019 17:47:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     devel@driverdev.osuosl.org, Michael Chen <micchen@altera.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191015144202.GI4774@kadam>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
 <20191009121441.GM25098@kadam>
 <20191009145811.GA3823@AlexGordeev-DPT-VI0092>
 <20191009185323.GG13286@kadam>
 <20191010085144.GA14197@AlexGordeev-DPT-VI0092>
 <20191010113034.GN13286@kadam>
 <20191015112449.GA28852@AlexGordeev-DPT-VI0092>
 <20191015131955.GH4774@kadam>
 <20191015143129.GA32565@AlexGordeev-DPT-VI0092>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015143129.GA32565@AlexGordeev-DPT-VI0092>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=908
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150132
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Ah that's fine then.  And since wr_flags[hw->d2h_last_id] is just
true/false then it doesn't matter if it races.

regards,
dan carpenter

