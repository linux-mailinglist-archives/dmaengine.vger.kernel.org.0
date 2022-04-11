Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F04FBA3D
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbiDKK7e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245732AbiDKK7a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 06:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C940E58;
        Mon, 11 Apr 2022 03:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3375B8121C;
        Mon, 11 Apr 2022 10:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B779CC385A5;
        Mon, 11 Apr 2022 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649674633;
        bh=ZNQVA/M8Q2O7+k/ddbWMeIkFCGFecU+Sa8c0sLoBaAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXOHAhexHw0CA4I5ggGKFryk6/ao7dG4ZLiHhZUGsjLOFPH65nQsFhtsWlaZQ9N1q
         WuRSVdS/MFeGJzAyO1gbqOHKaImysX/uZBwN8rrMAWbIlDaJRDzBjOmLhlsRoJfjYH
         Lf7gB3Ml4gny8dsYqavXcd3AlCBwQkdxTSNr7YeyS8ZtFj39FW34sp22W8nwUxT/eE
         1erogll5b/M96OwKYByOPn+bqPhaDC5y+N0hYWS6ySXfE82+7UB7CPRpf0YXgcnsZP
         e3/qMQgvUvtS5KrP7k/OVmd/WklzWehUoUbu/S7cWgTMiQYTbnf6MaXQdCQZVuDJ8x
         NL/hFlcPUgLaw==
Date:   Mon, 11 Apr 2022 16:27:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v3 0/3] dmaengine: Use platform_get_irq*() variants to
 fetch IRQ's
Message-ID: <YlQJhSH8YCcqJ+A2@matsya>
References: <20220404155557.27316-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404155557.27316-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-04-22, 16:55, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series aims to drop using platform_get_resource() for IRQ types
> in preparation for removal of static setup of IRQ resource from DT core
> code.
> 
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].

Applied, thanks

-- 
~Vinod
