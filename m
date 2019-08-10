Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EEE88CE3
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2019 21:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfHJT1u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Aug 2019 15:27:50 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:18193 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfHJT1r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Aug 2019 15:27:47 -0400
Received: from belgarion ([90.76.53.202])
        by mwinf5d31 with ME
        id nXTS2000D4MlyVm03XTeb7; Sat, 10 Aug 2019 21:27:43 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 10 Aug 2019 21:27:43 +0200
X-ME-IP: 90.76.53.202
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma: pxa_dma: no need to check return value of debugfs_create functions
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
        <20190612122557.24158-4-gregkh@linuxfoundation.org>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 10 Aug 2019 21:27:26 +0200
In-Reply-To: <20190612122557.24158-4-gregkh@linuxfoundation.org> (Greg
        Kroah-Hartman's message of "Wed, 12 Jun 2019 14:25:55 +0200")
Message-ID: <87tvaorfc1.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

Hi Greg,

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Also, because there is no need to save the file dentry, remove the
> variable that was saving it as it was never even being used once set.
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/dma/pxa_dma.c | 56 +++++++++----------------------------------
>  1 file changed, 11 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index b429642f3e7a..0f698f49ee26 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -132,7 +132,6 @@ struct pxad_device {
>  	spinlock_t			phy_lock;	/* Phy association */
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry			*dbgfs_root;
> -	struct dentry			*dbgfs_state;
>  	struct dentry			**dbgfs_chan;
>  #endif
>  };
> @@ -326,31 +325,18 @@ static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
>  					     int ch, struct dentry *chandir)
>  {
>  	char chan_name[11];
> -	struct dentry *chan, *chan_state = NULL, *chan_descr = NULL;
> -	struct dentry *chan_reqs = NULL;
> +	struct dentry *chan;
>  	void *dt;
>  
>  	scnprintf(chan_name, sizeof(chan_name), "%d", ch);
>  	chan = debugfs_create_dir(chan_name, chandir);
>  	dt = (void *)&pdev->phys[ch];
>  
> -	if (chan)
> -		chan_state = debugfs_create_file("state", 0400, chan, dt,
> -						 &chan_state_fops);
> -	if (chan_state)
> -		chan_descr = debugfs_create_file("descriptors", 0400, chan, dt,
> -						 &descriptors_fops);
> -	if (chan_descr)
> -		chan_reqs = debugfs_create_file("requesters", 0400, chan, dt,
> -						&requester_chan_fops);
> -	if (!chan_reqs)
> -		goto err_state;
> +	debugfs_create_file("state", 0400, chan, dt, &chan_state_fops);
> +	debugfs_create_file("descriptors", 0400, chan, dt, &descriptors_fops);
> +	debugfs_create_file("requesters", 0400, chan, dt, &requester_chan_fops);

This is not strictly equivalent.
Imagine that the debugfs_create_dir() fails and returns NULL :
 - in the former case, neither "state", "descriptors" nor "requesters" would be
   created
 - in the new code, "state", "descriptors" nor "requesters" will be created in
   the debugfs root directory

Apart from that it looks fine.

Cheers.

-- 
Robert
