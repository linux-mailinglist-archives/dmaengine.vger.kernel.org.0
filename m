Return-Path: <dmaengine+bounces-12503-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TLwwE01KVmq32wAAu9opvQ
	(envelope-from <dmaengine+bounces-12503-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 16:40:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EEC755F69
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 16:40:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dBfUezJ4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12503-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12503-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D1C83053C91
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F65E442115;
	Tue, 14 Jul 2026 14:33:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A637AA99
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 14:33:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039603; cv=pass; b=nzyOStsTgo1Z2GyQCfIaIBxGu1LEqaqZ5M9GCIzlpPPqR6uhyu87lY+lVJQXKJNuhg5nYTA8/8yBccOO+rk1cUgnW8pEtzTYq1nrT/pqZy4lB9meaDm0N5AYwsBX8mUAB2q/OHHsA8YNMgKP9FXFrwMjW0WVfXrrU6wg7JMGuvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039603; c=relaxed/simple;
	bh=gXFrmG6jEHln72CF693YGMzKjCQZLOAxrQG4Tt+4Pxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnmJzKRv9yORkcW5Hv6SW6fA+qhuhkt3C+hxFJWYTb8VvDVhANAI0Qcu/hVnTgrIN8W4nAGOpvlRom/qrY5/BhZxkKJNVnj4W3WvFlQ3wy21Dw3G1saBmaTL0WLNgQqxaj/ZOdNrA+wV0jw7riFW1o3AlMzC78o3Ze87/2F4lBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBfUezJ4; arc=pass smtp.client-ip=209.85.218.53
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1601d552a8so451808366b.2
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 07:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784039599; cv=none;
        d=google.com; s=arc-20260327;
        b=r/c97Dp1JMXBxVvC2sOhzq0LpIRmIOL4nEo1UnBFu0g5YReilFwT33OWO3nykmEbc2
         QjbuOyndPQB1ioHENWFHZGO6xqE9QZB/KJroLxL1qY3iPmpvQv3iR0er/vpZ2H5I7HvE
         kCybSpxe+wnq+U7FY2GrDAu2wkzY6kD70q8J/XIuBBZy6klRtfX5bjfwT0xUPuZ1gibI
         8V074/Z+X1BG5rzTD2HrEmzdPAKZb9bvbCGc7a105882KnUOPe17sc1HOP7rXK0MUMAP
         IhoAWbA+CkHfDbP1A/RqFqdxWFZhsD5FWa0+y8FR1XKkbXY8g3RkwwIv3zAOGsQ72gxi
         MKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=myhkGa3cSq7N/yY58culCXKcRn2P9s26LCZA9dzv22M=;
        fh=LrNcFdEhrpefA3p46T91DWpXdcR7XSDiDdo1vapaPSM=;
        b=A35XRx9JU+o+l6QwH7JLPBJX/Qmuf1x9xOGPRH7tQ5ExXQulr9VKa5T7mvB5byKS5v
         ha0V2rvIhWLLhAOmwHk3KDeNLcLo0b12zgv+PzEZkxV6KqCG/ue+O7MMKR9QBWX75M2q
         CvRofAZPnald1KkP94UV7B+NdoV/WIxcgAqsfwUDML/jskQpmSAGJ0kRa+2Co6BU7jF8
         6pPr0eT2SQynIhdjg9xmTbXkHwRwabzuUR+nMywjkQs4wb7+DAL1XoxYuw94Hdp19J2H
         zkhzZ5uHCuGY/V39H22JzdOxGvfhytu9z7kHUd0rIUE3kTqVn0YMMB/1nUSPGbP7/kRW
         HIGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784039599; x=1784644399; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myhkGa3cSq7N/yY58culCXKcRn2P9s26LCZA9dzv22M=;
        b=dBfUezJ47ekK7SmRkxPAn7qKA/64f8Nu42+m/AQQsYBbpgK8GoYVeMBc2qy/3F59RJ
         nQt8K7UV5U2e/PmahuiJs7JRjrgcYBEMajOO0fv2C72vpch51Ps2e0Za74rr4tTxal0w
         vcXXO4jz9p27zeGrTaPBMWNoUZKj9a/xUmnEmzb2fT7UQ4fMPuib5P35elAk3u1UpBLg
         5NLRLKsQII2P9UyOfbD9zR2YW9cESLyFhMWrAFIPFGmDJeSlHsOg9nx4x2Iaor/eO7Hi
         e55PST+tcvp7XNXZIQp+/7dEPdhqO9R5oNI5osvTBdotRmIxSYYuT2clQF1L9kkRGHyh
         R+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039599; x=1784644399;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=myhkGa3cSq7N/yY58culCXKcRn2P9s26LCZA9dzv22M=;
        b=NOXOoi/A4UC8vXNQrqT7E2U+RBNzvGnw/ULy4+iPetrd0/kgg1BGj95kfv8h19CbxM
         cWJusSrteJL+Z0DTU3E6MfdvxGKcgqFTCTW3etIeC0MpYoPQ3gXopoMRACfgujWkAd9s
         YgLQvUDAm6FWfBkbVldsWA33FM/Oav7sLEuaL9adyFZ8W431iIilWee9PlfFRN+YvmDm
         5ELRdHIlj7guI6cEedHm4GxJZjG34Kufnz5doILrr0y5QIOTSA2j0tyVLg/Dd/ioW+3Z
         bZI7F/gwvb8OizAzc75VmWCC5U11OaP46UwtOD3Y0lb6LluNFGHXSYOVNNK4s/7WsLyS
         GqVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpH7uNXTAHWmePCUGa+l7M3Q9y60mJly4N5mvYttbXPyFlpU3qsIVYXLhjkndXxcGf7cgTtsfw6Qvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCOAMXbACHgAsI0z6CBo/IO7ouXv0D69djlW3a2UisP0tW9ZP
	8hGOUTq4DmA7l0kRIeEMrpMzlq0vXqd1fPWT+JxxmPewUmoSA5PL/yJwxtW8Y+bBeL8L/M+Ggny
	34fgFcVywFzmi9JYv5dIq50CqljHe8Wc=
X-Gm-Gg: AfdE7clookLL6J3LZuQREr4kQdoxJ9OPSA/eb72jfTdob2wwz/gCvk+CxbSKmeV0RBM
	BATuZUT7l7CtvMXUGqkHv9u8G/kQtZKvwNPy2HSaKtllG8VLpUC350oD9o8F13u1EpzRR+ZYamk
	AM2Gs9jmvH514uxL2yTmItbP6Mp6Qq/1wlih2Li7Jd4NmX2XHCkiOqwd9EvoOPTpjszMZXCtCkS
	tESAHWRE5xwIpEvH+Gvp3M1xY0ZiHVdDuAlTH9A7kqHs/i/2WQZ0Wn90a6s8I2DVVKLfGZ3gx5U
	uvHldQNlmVZskzVRORWdwY2Q2gF7V3CkZx5JA5XBPQX5sf9Zf7wGBebmOLPg0g==
X-Received: by 2002:a17:906:4791:b0:c16:71:d9ce with SMTP id
 a640c23a62f3a-c1667996520mr142371366b.8.1784039599064; Tue, 14 Jul 2026
 07:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b0a22171f3ed68e156a2fa84383e99c23ec6b2ff.1784037977.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b0a22171f3ed68e156a2fa84383e99c23ec6b2ff.1784037977.git.christophe.jaillet@wanadoo.fr>
From: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
Date: Tue, 14 Jul 2026 19:59:36 +0530
X-Gm-Features: AUfX_mxwZgJqJ1IU2yY6JoQF_Xog1NgxPfEe0ScKaP2Rhn8fgDalvg7vZYXv3JM
Message-ID: <CA+LZ_WZXo2Dv_xTXT+raGCg=HMfcJ1O=8W6wJ2MAy9-iEYM4Vw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: Constify struct dma_descriptor_metadata_ops
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:christophe.jaillet@wanadoo.fr,m:vigneshr@ti.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	FORGED_SENDER(0.00)[sskartheekadivi@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-12503-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sskartheekadivi@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3EEC755F69

On Tue, 14 Jul 2026 at 19:45, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct dma_descriptor_metadata_ops' in not modified in these drivers.
>
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text    data     bss     dec     hex filename
>  120635   21584      64  142283   22bcb drivers/dma/xilinx/xilinx_dma.o
>
> After:
> =====
>    text    data     bss     dec     hex filename
>  120699   21520      64  142283   22bcb drivers/dma/xilinx/xilinx_dma.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
> Compile tested only.
> ---
>  drivers/dma/ti/k3-udma.c        | 2 +-
>  drivers/dma/xilinx/xilinx_dma.c | 2 +-
>  include/linux/dmaengine.h       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 1cf158eb7bdb..fb21e0df5ab7 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3408,7 +3408,7 @@ static int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
>         return 0;
>  }
>
> -static struct dma_descriptor_metadata_ops metadata_ops = {
> +static const struct dma_descriptor_metadata_ops metadata_ops = {
>         .attach = udma_attach_metadata,
>         .get_ptr = udma_get_metadata_ptr,
>         .set_len = udma_set_metadata_len,
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 98b41b8f8915..bef2b031dba1 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -655,7 +655,7 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>         return seg->hw.app;
>  }
>
> -static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
> +static const struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
>         .get_ptr = xilinx_dma_get_metadata_ptr,
>  };
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 6fe46c0c9452..fe33a20abc61 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -631,7 +631,7 @@ struct dma_async_tx_descriptor {
>         void *callback_param;
>         struct dmaengine_unmap_data *unmap;
>         enum dma_desc_metadata_mode desc_metadata_mode;
> -       struct dma_descriptor_metadata_ops *metadata_ops;
> +       const struct dma_descriptor_metadata_ops *metadata_ops;
>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>         struct dma_async_tx_descriptor *next;
>         struct dma_async_tx_descriptor *parent;
> --
> 2.55.0
>
>

