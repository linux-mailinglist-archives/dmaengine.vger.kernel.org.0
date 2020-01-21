Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4429814394F
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 10:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAUJSW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 04:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgAUJSW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 04:18:22 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E00B20882;
        Tue, 21 Jan 2020 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579598302;
        bh=Av5gdOfl5MZxDWJWCUwS+Ht2tJcEg7680G4U01+PMlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkrxOBJoua6D/Xb7I1ADXosDl7CioTk52LJmXCSik9wStplRlsxgFB2IK9yheHtcS
         QFCcLRKt9F3P2skQUvm9W7eJT0ORMbxBcrpj4choPIN3N1lDJINbBQZfHZPgFJe6a4
         uYNMU/UYRs1oZAdCRCoya/RWyKakjZaH6hLa01fE=
Date:   Tue, 21 Jan 2020 14:48:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Matthias Fend <matthias.fend@wolfvision.net>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        michal.simek@xilinx.com
Subject: Re: [PATCH] dmaengine: zynqmp_dma: fix burst length configuration
Message-ID: <20200121091818.GG2841@vkoul-mobl>
References: <20200110082607.25353-1-matthias.fend@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110082607.25353-1-matthias.fend@wolfvision.net>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-01-20, 09:26, Matthias Fend wrote:
> Since the dma engine expects the burst length register content as
> power of 2 value, the burst length needs to be converted first.
> Additionally add a burst length range check to avoid corrupting unrelated
> register bits.

Applied, thanks

-- 
~Vinod
