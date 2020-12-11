Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB602D79B3
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 16:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392807AbgLKPol (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 10:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392647AbgLKPoB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Dec 2020 10:44:01 -0500
Date:   Fri, 11 Dec 2020 21:13:16 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607701401;
        bh=FRBMjCg3FCwVVASnJpRiHWLuuSl0y2YodCYJbNsoGdU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0DrGVs/u68kbw5sOCkD0vCmo/IVJESNaporahpgBslAFXbA6t2u3Ra+pYUAHqbq2
         P10xkJrsBev1j4A760lWxp6j96Lfz98k75rIu28Nz7U38MJDeEfOQ0qL8gtdHvtm67
         chAwtqoNhfYBPmc/JcN++wDybvNy8scRamNAeur1TSOINFn+F74MC3DT1HWeImkYDM
         1gt7taHHbwszM1bk6pKsmyb/ad03pwugBgXXrCzyd8FrA7mtGiHSwdSUNUhqLnku8n
         G01np4tE1lEx03JuNQra94FixpWAnoCHd+GDZg4fUKDQysXOI4vhoTUgaAijU7nJBg
         Dd2ChKc5Q7u4g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 0/4] Bunch of improvements for STM32 DMA controllers
Message-ID: <20201211154316.GY8403@vkoul-mobl>
References: <20201120143320.30367-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120143320.30367-1-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-11-20, 15:33, Amelie Delaunay wrote:
> This series brings 3 patches for STM32 DMA and 1 for STM32 MDMA.
> They increase the reliability and the efficiency of the transfers.

Applied, thanks

-- 
~Vinod
