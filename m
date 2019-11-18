Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76653FFF97
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 08:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfKRHgy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 02:36:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37432 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKRHgx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Nov 2019 02:36:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI7YBTO038039;
        Mon, 18 Nov 2019 07:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=HEgLCG6dwm31S4YF+LeCFKqLGvuxdslqV4Lkz+eo3bs=;
 b=ZEHsflysbpNRDdbazaAb1IBwTtXhTK3yOhEfjPAfgFNuZHMZ+y7OUifdpjFZhjYjnz2X
 PSQuSBDiY8kVh0u0NK/cQgWE7vQHPs6ZRpFc2rYwwL2sxO3UGSzgz2CwW46sArcYWq1N
 B0uKWWqTK8938TGP1RkCr9YUrekVDvKOeYq/KaJPU83xP08FRU3cA7TsI98Epjc/CPuX
 KbIMnFe7CshzVsq0FYO6QmgvSf6JuKDz29iEqCM/m9ZYuoEpYxDCeAgBBlA4eIeFnaIQ
 qaJVC1UoB1hBZDtLaNjIMM26yXKrlcCsLEotuPR56HBpfRXgTFfNXSAdcFi0wOP3J9Ry kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wa92pe8sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 07:36:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI7XDYW102874;
        Mon, 18 Nov 2019 07:36:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2watjwyubg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 07:36:49 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAI7am5n012499;
        Mon, 18 Nov 2019 07:36:48 GMT
Received: from kadam (/41.210.155.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Nov 2019 23:36:47 -0800
Date:   Mon, 18 Nov 2019 10:36:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Green Wan <green.wan@sifive.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [bug report] dmaengine: sf-pdma: add platform DMA support for
 HiFive Unleashed A00
Message-ID: <20191118063704.GC1776@kadam>
References: <20191116082253.mdowmeywwtroo6xt@kili.mountain>
 <CAJivOr7ZaZWzw-5QnOkakmBhN3TidzoM_WwDVpPAsaGp5tMw-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJivOr7ZaZWzw-5QnOkakmBhN3TidzoM_WwDVpPAsaGp5tMw-Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180066
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 18, 2019 at 12:25:14PM +0800, Green Wan wrote:
> Hi Dan,
> 
> Thanks for reaching out. I do have the same question before. If I
> remember it correctly, the 'chan' is returned by to_sf_pdma_chan()
> which contains 'dchan'. 'chan' s unlikely to be NULL since it's
> container.

to_sf_pdma_chan() is really a no-op when you read it carefully.  "chan"
and "dchan" are equivalent.  Smatch parses it correctly.

You are obviously correct that people should check the original "dchan"
instead of the returned "chan", but I feel like some people are clever
enough to know when container_of() is a no-op and deliberately check the
returned value...  These are sorts of people you don't want to get into
a debate with because they're an ultra annoying blend of clever and
dumb.

My other comment here is that Smatch doesn't warn about inconsistent
NULL checking when the pointer is provably non-NULL.  In this case, the
only caller that Smatch doesn't parse correctly is ioat_dma_self_test().
For all the other callers it knows that "dchan" is non-NULL.  In
ioat_dma_self_test() the code looks like:

   330          /* Start copy, using first DMA channel */
   331          dma_chan = container_of(dma->channels.next, struct dma_chan,
   332                                  device_node);

Smatch says that both "dma->channels.next" and "dma_chan" are complete
unknowns.

I could probably safely mark dma_chan as a valid pointer in this
instance which would make the warning disappear...  Maybe I will add a
check to see if "dma->channels.next" can be controlled by the user.

regards,
dan carpenter

