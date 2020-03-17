Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0980818846B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2020 13:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQMmd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Mar 2020 08:42:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46176 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQMmd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Mar 2020 08:42:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02HCfSk6167867;
        Tue, 17 Mar 2020 12:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qLXLoc2iW/txP0dNGrHzr3+4kcMjVEsFRgTXm08hbuo=;
 b=vN6LrebwJPlYrnL/Hr4bdHMcqlekUqj21CernyAo4b0WTX7xhNijPuLsxyYZ4mn0Nzvk
 LJYy0yS6sFxr3F4Nx1FNjOD6zkszqphexFIoD2BVAKS0ciZD0j0DkJdV0JKtTRrJJRI/
 JRUBYqNjOlkhaVj4RyZZySRiMpafv05BobF2EtMkGHuPmNCkj1vOIu8/o3WjRkyqV2cs
 GzGphnbu1kwnpDVnsLi79oJB4iWVwjKcXwdG8Q2oELU8TGldfZVZvV5Q+GCo//mm2ykr
 62JmCiYRbXOiRwdaLuDsU4i2+SO1bqJYVm1+G6hgWWAetJybb/t3xkiLpEmSXNd8bCsk +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yrqwn4fey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 12:42:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02HCacia060428;
        Tue, 17 Mar 2020 12:42:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ys8trrnph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 12:42:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02HCgQGj023511;
        Tue, 17 Mar 2020 12:42:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Mar 2020 05:42:25 -0700
Date:   Tue, 17 Mar 2020 15:42:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix an error handling path in
 'k3_udma_glue_cfg_rx_flow()'
Message-ID: <20200317124217.GB4650@kadam>
References: <20200315155015.27303-1-christophe.jaillet@wanadoo.fr>
 <49a35126-3cc6-0cbb-e632-42a237ef353e@ti.com>
 <e1d2d6af-7dc3-6e90-28d3-05d9b293cba9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d2d6af-7dc3-6e90-28d3-05d9b293cba9@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=2 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003170056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=2
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170056
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 17, 2020 at 09:50:52AM +0200, Grygorii Strashko wrote:
> Hi Christophe,
> 
> On 16/03/2020 09:20, Peter Ujfalusi wrote:
> > Hi Christophe,
> > 
> > On 15/03/2020 17.50, Christophe JAILLET wrote:
> > > All but one error handling paths in the 'k3_udma_glue_cfg_rx_flow()'
> > > function 'goto err' and call 'k3_udma_glue_release_rx_flow()'.
> > > 
> > > This not correct because this function has a 'channel->flows_ready--;' at
> > > the end, but 'flows_ready' has not been incremented here, when we branch to
> > > the error handling path.
> > > 
> > > In order to keep a correct value in 'flows_ready', un-roll
> > > 'k3_udma_glue_release_rx_flow()', simplify it, add some labels and branch
> > > at the correct places when an error is detected.
> > 
> > Good catch!
> > 
> > > Doing so, we also NULLify 'flow->udma_rflow' in a path that was lacking it.
> > 
> > Even better catch ;)
> > 
> > > Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine user")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > Not sure that the last point of the description is correct. Maybe, the
> > > 'xudma_rflow_put / return -ENODEV;' should be kept in order not to
> > > override 'flow->udma_rflow'.
> > > ---
> > >   drivers/dma/ti/k3-udma-glue.c | 30 ++++++++++++++++++++----------
> > >   1 file changed, 20 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> > > index dbccdc7c0ed5..890573eb1625 100644
> > > --- a/drivers/dma/ti/k3-udma-glue.c
> > > +++ b/drivers/dma/ti/k3-udma-glue.c
> > > @@ -578,12 +578,12 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
> > >   	if (IS_ERR(flow->udma_rflow)) {
> > >   		ret = PTR_ERR(flow->udma_rflow);
> > >   		dev_err(dev, "UDMAX rflow get err %d\n", ret);
> > > -		goto err;
> > > +		goto err_return;
> > 
> > return err; ?
> > 
> > >   	}
> > 
> > Optionally you could have moved the
> > 	rx_chn->flows_ready++;
> > here and
> 
> Thank you for your patch.
> 
> I tend to agree with Peter here - just may be with comment that it will be dec in
> k3_udma_glue_release_rx_flow().
> All clean ups were moved in standalone function intentionally to avoid
> code duplication in err and normal channel release path, and avoid common errors
> when normal path is fixed, but err path missed.

A standalone function to free everything is *always* going to be buggy.
This patch is the classic bug where when you "free everything", you end
up undoing things that haven't been done.

The best way to do error handling is to 1) Free the most recently
allocated resource and 2)  Use label names which say what the goto does.

With multiple labels like "goto err_rflow_put;" the review only needs to
ask, what was the most recent allocation?   In the case, it was
"udma_rflow" and the "goto err_rflow_put" puts it.  That's very simple
and correct.  There is no need to scroll to the bottom of the function.

When it comes to line count, if we only free successfully allocated
resources then it means we can remove all the if statements from the
k3_udma_glue_release_rx_flow() so the line count ends up being similar
either way.

The other problem with "common cleanup functions" is that when people
want to audit it, instead of looking at the gotos, reviewers have to
open up two terminal windows and go through it line by line.  Currently
static analysis tools are not able to parse common clean functions.

Christophe's patch doesn't just fix the bug he observed, it also fixed
at least one other double free bug.  It's quite hard to spot the second
bug, but Christophe fixed it automatically by following the rules.

regards,
dan carpenter


