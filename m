Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0104721E9
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhLMHtE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 02:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLMHtE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 02:49:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D07C06173F;
        Sun, 12 Dec 2021 23:49:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E51FB80DC3;
        Mon, 13 Dec 2021 07:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC39C00446;
        Mon, 13 Dec 2021 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639381741;
        bh=ZBr26fW8SEEPQKnMIuVCSbNTJr1TjALGEo+Idc+TQa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JazxAMQsoyEjlMTZkBohd9hc98iewAPoNVNnzgN9CFwtvFpyOjHY5o/vbXlqn3IkB
         L1DZMIsC3nmIVDF5deQUq1P8fXkcAtSJUvAeUMBnTOMQaNlulDCg4R4JRX/CPyOrBh
         VG4B1FCCsj9LEC+uAU1Z9QEONRJrsaB/K03D7G+kFqM1WpnmKZpYP/XfvdaaFT5R1+
         P5Arx9sTtLNx/gaXDYU/1BKTscLGIgqWkLC0tDvckA1h3gtfsobUh66bEOZWsmChOf
         EiG7kbqlT7fueHtFa6O30budxcDSJAunkSzakPyF8fQcd1QYfJfUQiawgW9zBiNoLA
         FArTvCMyyfsXA==
Date:   Mon, 13 Dec 2021 13:18:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        "moderated list:ARM/STI ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: st_fdma: fix MODULE_ALIAS
Message-ID: <Ybb66JpLyJ884a5f@matsya>
References: <20211125154441.2626214-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125154441.2626214-1-hi@alyssa.is>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-11-21, 15:44, Alyssa Ross wrote:
> modprobe can't handle spaces in aliases.

Applied, thanks

-- 
~Vinod
