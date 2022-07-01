Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9EA563814
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiGAQhK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiGAQhJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 12:37:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C952C37A3D;
        Fri,  1 Jul 2022 09:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8977CB83090;
        Fri,  1 Jul 2022 16:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5645C3411E;
        Fri,  1 Jul 2022 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693426;
        bh=dvn0q53TXBDnV3Qt4aSdr2WzDOqUHtfan8BhemxpCOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkiDgZpOfaN9dOsDRrcDsbMySgGbQpKCeO+no3q1kSX+1cRgqA2x4iEzPdY/XW3UF
         1+2xoNv9YCEy7Q2lYD4OCwmmWsdnAYTFzcCjV1CrNKS8xmZXVPb+0Uelzf5iWfWx7g
         prCRoRfZtwtTMVw3j99tU/q+FAW+tbfcH1E/MTMPYNnmoM3XhZbgodSspBaCkRzIHH
         eXzeCb2+JRoT7Rs2YCkucN713hRlcycMY3jm5NsgaWoDCC0dtJv6efdUljoPTbJ5Oy
         v9buw0XVWJyeh4Dc2K3+zmhU0AgZLwv2zdi6fW/VbhS9zqdApMrLm9fSDidJRNrAH8
         4Eut+nwcApcRQ==
Date:   Fri, 1 Jul 2022 22:07:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: mtk-hsdma: Fix typo in comment
Message-ID: <Yr8ircxQa4I7/jmW@matsya>
References: <20220618130120.9783-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618130120.9783-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-22, 21:01, Xiang wangx wrote:
> Delete the redundant word 'be'.

Applied, thanks

-- 
~Vinod
