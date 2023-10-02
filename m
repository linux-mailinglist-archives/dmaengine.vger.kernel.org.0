Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CB7B5A2D
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjJBSPS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 14:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjJBSPR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 14:15:17 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC349B;
        Mon,  2 Oct 2023 11:15:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6B2E6320091D;
        Mon,  2 Oct 2023 14:15:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 02 Oct 2023 14:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696270509; x=1696356909; bh=uR
        S/QTAVgBh7L/9LkPU+PyiGZfA3tlSQT3X4KW7xwd8=; b=dYMG1Yyurl/oazmolW
        YPjvGutWSOgcYvTSOi+1cZybxQijDIjRMWA6JSU3h1jchT8kHqWJtbctHihnSvdl
        hh02U/SOzqRk/Hbgwg2oGhDk8EfPPnurDCigqDA9XuduoSF1hAJoa1sohLbzy0B8
        Ad2RjoVHKQv9rhmQr87N9oqcXeI6CQUheGnvZxwKMiemRBlLQ4QcqKMCS2PKBcnR
        48ZcaMuviNSf1z7Vi7XVGawgChdsLDqslLnEbuy7W2/xxOlSgwiKx5Y07a56fYXK
        DP1jEhDzPyaiWq7n/zvFK2NvPo762pFVFq4/pa1Y+3R5MlCc+x6CTubT1CRZ7ND3
        TG1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696270509; x=1696356909; bh=uRS/QTAVgBh7L
        /9LkPU+PyiGZfA3tlSQT3X4KW7xwd8=; b=p4DVBL9mBNEy8PMdkvmCdCricnbwx
        nz5TMEX+Us1aqEQhhM7RGjGZkdHqPK96SvqzKweyKJhnK44zZXmFjkcecZ1zPZAs
        O/RABv94pmSO6s4tiNmENzK68Fpy29Pmf+GpyIMicdTkJW6Xae5AWzYu9WxJ83kU
        PHaHzhV0ODRJKPh4u15cSdNpDZ0nlAIZfA+DdhxieATEzZ6UDy2FAGwL5L1OGzPY
        LkC0LXL6rjuXNiUsvOl1d4pIvrwM4q45OSkSYZd+KtpRM4MiwSVAkI9ZrmY8ARyK
        xlPeOiPSFfXBovA4FD21fjBw3qW/vQP8+dEWjtKToHY1kEKwZh4OMV0hg==
X-ME-Sender: <xms:rQgbZaRskk_cDgkDrDsMwEZ0tG3fMZ3Q2sQg99DlOKibpJZY1JMIbQ>
    <xme:rQgbZfy1GRZLnQ-RyHGaPLrhueUSei4-5yHfywagtfk1MBGS8p94nzgKX8upxCmIO
    CGhRSP63aXLJtT38P0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rQgbZX08I8Z2ZsRK4ZMB3FjrXkEH1V5LgetAxeDQzE9tMf4w1yB-3w>
    <xmx:rQgbZWB7eHNsVTekXyxSkSVnbSzQWMCjFinGUVuokhstBZ1lzocisg>
    <xmx:rQgbZTiM6KEs10yLt09HbKCAqGq405lBj-C-TUQtGsroVa17W6vYvw>
    <xmx:rQgbZTi3jLjKmGXAe2UYThnqBk-rEmccG-vcYkKSIKFGa5qL5n9uXQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2503AB60089; Mon,  2 Oct 2023 14:15:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <32cd13af-21fa-45bf-9250-b5f3ca132b9b@app.fastmail.com>
In-Reply-To: <20231002145737.538934-1-Frank.Li@nxp.com>
References: <20231002145737.538934-1-Frank.Li@nxp.com>
Date:   Mon, 02 Oct 2023 20:14:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Frank Li" <Frank.Li@nxp.com>, "Baoquan He" <bhe@redhat.com>
Cc:     dmaengine@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>
Subject: Re: [PATCH v2 1/1] fs: debugfs: fix build error at powerpc platform
Content-Type: text/plain
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 2, 2023, at 16:57, Frank Li wrote:
> ld: fs/debugfs/file.o: in function `debugfs_print_regs':
>    file.c:(.text+0x95a): undefined reference to `ioread64be'
>>> ld: file.c:(.text+0x9dd): undefined reference to `ioread64'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202309291322.3pZiyosI-lkp@intel.com/
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

I still think this is wrong, for the reasons I explained in
https://lore.kernel.org/all/b795ed61-0174-487f-a263-8431e7c76af5@app.fastmail.com/

The part that I had missed earlier is how this is
related to GENERIC_IOMAP, since on those architectures,
the ioread helpers are not just fixed-endian MMIO accessors
like readl and readq but also multiplex to the PIO functions
(inb/inw/inl) that do not have a 64-bit version because x86
and PCI both only define those up to 32 bit width.

The best workaround is probably to use readq() instead of
ioread64(), or swab64(readl()) instead of ioread64_be().

This should work on all 64-bit architectures, plus any 32-bit
one that defines readq(), so you can just use an 'ifdef readq'
around the call.

     Arnd
