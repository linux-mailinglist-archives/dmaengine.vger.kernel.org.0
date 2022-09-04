Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681EA5AC5BA
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 19:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiIDRYc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 13:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiIDRYc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 13:24:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C1D134;
        Sun,  4 Sep 2022 10:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A57E9B80E28;
        Sun,  4 Sep 2022 17:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABAAC433D6;
        Sun,  4 Sep 2022 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662312266;
        bh=KM+tXy5ruBifHaiU7QANp5OKx2GDwpl5tXPjBlBNfbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8p4PsGm4uykiEURez0U+dWyYh2ygeMSQ7O/sC4O/v6wtkiYYynmmkCqnOZv4D8ne
         K35s6+tZJODK+lQOUfLkl/b7ADvl38+jBRCiLqLNI9F7y/g8roYN4e0LoW8q4+cpR3
         I/JDjhzjV06bM1n92/iO2c04Nf7qgzSID4ysJh5SXqit1L+OZ/cmwlaDbj94TghbHg
         AC6Ut0qct/47774GEu3Hj73/HmkpEwjMqzWbSIAP6IoBoXhnOM5aimRcm9CKgMEsDw
         YBaRqM28bD2dNn4nD2Z+HCWUXqmjwotWKNZcHb8tHYl6AixtcFTmjD97kyyMmwQlQX
         8UhMY4RbCJJyg==
Date:   Sun, 4 Sep 2022 22:54:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swati Agarwal <swati.agarwal@xilinx.com>
Cc:     lars@metafoo.de, adrianml@alumnos.upm.es, libaokun1@huawei.com,
        marex@denx.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harini.katakam@xilinx.com, radhey.shyam.pandey@xilinx.com,
        michal.simek@xilinx.com, swati.agarwal@amd.com,
        harini.katakam@amd.com, radhey.shyam.pandey@amd.com,
        michal.simek@amd.com
Subject: Re: [PATCH v2 0/3]  dmaengine : xilinx_dma: Fix error handling paths
Message-ID: <YxTfRPgOItCAiyui@matsya>
References: <20220817061125.4720-1-swati.agarwal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817061125.4720-1-swati.agarwal@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-08-22, 11:41, Swati Agarwal wrote:
> Fix Unchecked return value coverity warning.
> Fix probe error cleanup.

Applied, thanks

-- 
~Vinod
