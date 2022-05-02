Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5B516CFC
	for <lists+dmaengine@lfdr.de>; Mon,  2 May 2022 11:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiEBJJq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350471AbiEBJJf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 05:09:35 -0400
X-Greylist: delayed 210 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 02:06:05 PDT
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205D5FC6;
        Mon,  2 May 2022 02:06:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D629B425F5;
        Mon,  2 May 2022 09:05:58 +0000 (UTC)
Message-ID: <8d60761d-178f-2da1-ffac-34a33d6c4669@marcan.st>
Date:   Mon, 2 May 2022 18:05:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/7] mailbox: apple: peek_data cleanup and implementation
Content-Language: es-ES
Cc:     Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220502090225.26478-1-marcan@marcan.st>
To:     Jassi Brar <jassisinghbrar@gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220502090225.26478-1-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/05/2022 18.02, Hector Martin wrote:
> Cc: Anup Patel <anup.patel@broadcom.com>
> Cc: Vinod Koul <vkoul@kernel.org> (maintainer:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)
> Cc: Sven Peter <sven@svenpeter.dev> (maintainer:ARM/APPLE MACHINE SUPPORT)
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io> (reviewer:ARM/APPLE MACHINE SUPPORT)
> To: Jassi Brar <jassisinghbrar@gmail.com> (maintainer:MAILBOX API)

Sigh, why do I always screw up git send-emails...

Jassi: this was supposed to be for you, but I had a spurious newline in
the cover file and that dropped the to: (but not the cc:s). Let me know
if you need the whole thing resent if you didn't get it via lists. My
apologies.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
