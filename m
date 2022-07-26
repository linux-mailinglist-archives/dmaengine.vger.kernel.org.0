Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE485813B3
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 14:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiGZM6q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiGZM6q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 08:58:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DDF2981A;
        Tue, 26 Jul 2022 05:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C904B810A9;
        Tue, 26 Jul 2022 12:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059AFC341C0;
        Tue, 26 Jul 2022 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658840322;
        bh=XRAHj+U74Bn1IxA6/ezqxJTO1Dc5KTDSRz62l75xUH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHebwwsen/LsE9W44EU6JI+1ozgrvgsq2OO8UO9jT0ntcScZDMWPTW9jI6co9mUNa
         xfaI80MiCRBkdn88NYcA++TCSnCt3J7LU0hBqqK2kDlrQ9VbO116wwYjbsSpzv7I2Q
         xuRMcmZOtkf81Mgd2w1269gKU1OXlP/ZfaHZawCayNQJqnGH/dD3ayTnYX0m9whgyA
         TJpc8x7WDXFbsjqATSth+jYyYvOUOxLAAwxFXCiZUSzrq6UW0M5vMvvulsqJZ1UL0z
         fyRJkYR7aM70RA8mwkfGC1KYKiW/Xc6Vvi0Ad2aNxfdO841KL6WsHSdkf9I1KdpyyP
         Z4cm6xsDXEyAg==
Date:   Tue, 26 Jul 2022 18:28:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Colin Ian King <colin.king@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: sh: rz-dmac: Add device_synchronize
 callback
Message-ID: <Yt/k/UD089k4Lkl8@matsya>
References: <20220722084430.969333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722084430.969333-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-22, 09:44, Biju Das wrote:
> Some on-chip peripheral modules(for eg:- rspi) on RZ/G2L SoC
> use the same signal for both interrupt and DMA transfer requests.
> The signal works as a DMA transfer request signal by setting
> DMARS, and subsequent interrupt requests to the interrupt controller
> are masked.
> 
> We can re-enable the interrupt by clearing the DMARS.
> 
> This patch adds device_synchronize callback for clearing
> DMARS and thereby allowing DMA consumers to switch to
> interrupt mode.

Applied, thanks

-- 
~Vinod
