Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9035C282
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 12:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhDLJpW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 05:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243070AbhDLJlQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 05:41:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA17C61221;
        Mon, 12 Apr 2021 09:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220458;
        bh=doYnKmWvvFZJu0dQidagDHHTL22R/NmtwWLIsanGgmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JtcfxJvkAh1LM3t2ai/DSDFLRAA6MPqSI+Ve/dsqSdGJvuLkEKl+w9R2ME2AH4k9a
         PROhYB7hanmdap0MPlr+YjZo1qhcSy1tVyCqIMx4zVGv+tYh4VA+ITiaiTcB82GMbw
         QOn3eJ9ng+gcFK+ARmI8isTGydvZaHoWDrXyFH0eaRy/hrgtA1CX8C5v1UQ+KD+lyN
         f/tUS9QRAlsbvE+q3XQrhQ2jxVi0rwhwybM28Nv5SeLUdZO9+l0Wbq0KbJQ1yyKKJg
         2YovP1KNQ0mT6mgUSUMM3+5OMZbxA0gGxhKefXOSbTLXijLuFFr8bBMcmdUTWU9lhj
         Ihl1EX/TbOWiA==
Date:   Mon, 12 Apr 2021 15:10:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dmaengine: tegra20: Fix runtime PM imbalance on
 error
Message-ID: <YHQVph37qKYy5bHo@vkoul-mobl.Dlink>
References: <20210409082805.23643-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409082805.23643-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-04-21, 16:28, Dinghao Liu wrote:
> pm_runtime_get_sync() will increase the runtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.

Applied, thanks

-- 
~Vinod
