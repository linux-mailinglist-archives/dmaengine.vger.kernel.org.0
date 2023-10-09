Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BF27BD2D0
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 07:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbjJIF2m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 01:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIF2l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 01:28:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93899E;
        Sun,  8 Oct 2023 22:28:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A563FC433C7;
        Mon,  9 Oct 2023 05:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696829320;
        bh=fbbHSYshw5Kz8wrmfmbPPDnJll59jMVtKXH08Xmcpf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crXB+3st26GpK9f/Oi9lMlUZ4Vy2DQZQtXvbyICbSvRRkO+L5DOSrz0m1vYAnXUEL
         G/x9zcysEgDwMTQ/B1Vo3/7aw4O6SIpma+w5psrhjPw6M2Qby4jWFO/8ACwLBjOO3m
         C6T0um/KOXrYZz4la79IhwEpl9ZdoQJkDk0CV9pZ3ocRZIA5K2qsuH1FPVmbQp/okl
         vDln5eUbhdIcm+PmYV1UCEb4xIJrAEQj6NO7LT8Pj7cz5+8ZMn575WM66BM/exzojq
         sUF1NkyOqnTtgl8gHWPXjae6+Tcy9iexzdrdowEM6QSsQRq8vz4imkvcUUg623bE25
         aLAhrEUW53p6A==
Date:   Mon, 9 Oct 2023 10:58:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Michal Simek <monstr@monstr.eu>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ASoC: soc-generic-dmaengine-pcm: Fix function
 name in comment
Message-ID: <ZSOPhDrySHgWnVv3@matsya>
References: <20231005160237.2804238-1-miquel.raynal@bootlin.com>
 <20231005160237.2804238-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005160237.2804238-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-10-23, 18:02, Miquel Raynal wrote:
> While browsing/grepping in the sound core, I found that
> snd_dmaengine_set_config_from_dai_data() did not exist, in favor of
> snd_dmaengine_pcm_set_config_from_dai_data(). Fix the typo.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
