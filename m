Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEC73E2BEF
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhHFNvw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 09:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232646AbhHFNvv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 09:51:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 306BB61165;
        Fri,  6 Aug 2021 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628257896;
        bh=ak6QdYrg0837VTHHvLm3hnnK13Xva4e89+glyF7lrV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkIXkOyHTECjvjqEmsd9enCtu7K19SaEGjHkiTacinrRy+ELOl3Wqah14yKOIDuel
         hZQdA0gK80OIAOfxvVIzRyq6QgPaChGn7eCHtabg2nnNaSfpPAtDoJ6gz21Q/NXByn
         ZMgib7OHx+wgMbQD4VnHWuGj8CbkINe4k9HkuW38dSI8gGdPs7G9ChsQizT9NPnibz
         ATg+mt7475Ga1jd5WxEctPkGcbOSau8C/02l14pRoSs6mtsRDjzZ57UYQJoKelc3Xc
         kCyWqfT4LegLrW0gACy8lhVfzrX8sNL7CqEIDwzIVmOIwcCxLS9qOtVbWJJ/hvxLao
         /90PXPeM0IEmw==
Date:   Fri, 6 Aug 2021 19:21:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     dmaengine@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH V3] dmaengine: xilinx: Add empty device_config function
Message-ID: <YQ0+Y8IUENKMHVDf@matsya>
References: <20210804195140.61396-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804195140.61396-1-marex@denx.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-08-21, 21:51, Marek Vasut wrote:
> Various DMA users call the dmaengine_slave_config() and expect it to
> succeed, but that can only succeed if .device_config is implemented.
> Add empty device_config function rather than patching all the places
> which use dmaengine_slave_config().

Applied, thanks

-- 
~Vinod
