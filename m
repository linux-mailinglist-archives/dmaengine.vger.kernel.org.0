Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E685526F71E
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIRHgs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 03:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIRHgr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 03:36:47 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67993208C3;
        Fri, 18 Sep 2020 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600414607;
        bh=tMJIGp6t8urEiQ2aBUoOKPVUceqzRsigcnMd9YF0FSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEZ+KEuD3hZrmbk53MT3WkYUZ9D1Ogv5S65S4pQb9gtOHaOmFSs+TcVWHG1e0/PK6
         zDWVIzHc81iurFyMFWs3HjGuWrS2JuCmn+eDR4GXQVNWXGh4IdgtfW4AcMgIxTkyRb
         +EQVhc1QbK5YWPeBvPXr7nWrO2+ul9LTxdrdqBLM=
Date:   Fri, 18 Sep 2020 13:06:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma-glue: fix channel enable
 functions
Message-ID: <20200918073643.GM2968@vkoul-mobl>
References: <20200916120955.7963-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916120955.7963-1-grygorii.strashko@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-09-20, 15:09, Grygorii Strashko wrote:
> Now the K3 UDMA glue layer enable functions perform RMW operation on UDMA
> RX/TX RT_CTL registers to set EN bit and enable channel, which is
> incorrect, because only EN bit has to be set in those registers to enable
> channel (all other bits should be cleared 0).
> More over, this causes issues when bootloader leaves UDMA channel RX/TX
> RT_CTL registers in incorrect state - TDOWN bit set, for example. As
> result, UDMA channel will just perform teardown right after it's enabled.
> 
> Hence, fix it by writing correct values (EN=1) directly in UDMA channel
> RX/TX RT_CTL registers in k3_udma_glue_enable_tx/rx_chn() functions.

Applied, thanks

-- 
~Vinod
