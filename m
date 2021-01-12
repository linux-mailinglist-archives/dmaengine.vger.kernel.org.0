Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37A2F2F1F
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbhALMbv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 07:31:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbhALMbv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 07:31:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D25421D93;
        Tue, 12 Jan 2021 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610454670;
        bh=EptgfiHYt6xGNsbmNtRX9LOhlDhS7JjIKitMyr9pz1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz8SebBY2hyY6tSaQrcbqEsiBzn1EKAhAK4cQ+pVHn/zT2Q2Ui+OqCztY6/aw5mZ/
         ZXvIwNXq/fhrH2A1Jd6oj8mBbe9VzaPoue/fixkHEEG67C1PPJ26nXrAkV63fXhRq1
         11EGaPLBAGxyezGWYkXR3l4AMEPH+iemdXaEDFXLrWdeESvUoQ8q/XlRjGO5M+p+Vx
         8Jfbr5q0NywitAdQnUoMSHQ4T4KKnDGSPgsivxkHH+06jxjF0ufLmnRrzLk4OQYpR8
         T2GHrCZVz/Yog5uWOkCc9XTG9JkN/uLvccgGVFRwcS0zKSyr24fZ5P7C9nVb+2yRgK
         WnND0THzJXZfw==
Date:   Tue, 12 Jan 2021 18:00:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     leoyang.li@nxp.com, zw@zh-kernel.org, dan.j.williams@intel.com,
        timur@freescale.com, linuxppc-dev@lists.ozlabs.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: fsldma: Fix a resource leak in the remove
 function
Message-ID: <20210112123057.GS2771@vkoul-mobl>
References: <20201212160516.92515-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212160516.92515-1-christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-12-20, 17:05, Christophe JAILLET wrote:
> A 'irq_dispose_mapping()' call is missing in the remove function.
> Add it.
> 
> This is needed to undo the 'irq_of_parse_and_map() call from the probe
> function and already part of the error handling path of the probe function.
> 
> It was added in the probe function only in commit d3f620b2c4fe ("fsldma:
> simplify IRQ probing and handling")

Applied both, thanks

-- 
~Vinod
