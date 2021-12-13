Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530034720CB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhLMFyY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:54:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47170 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhLMFyY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:54:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1CF21CE0AE2;
        Mon, 13 Dec 2021 05:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF09C00446;
        Mon, 13 Dec 2021 05:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639374860;
        bh=uMp9Frd+ytv1peiXkZhsAEN3vAJFoufdiK8l9LTVF4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpAN9ESTmomOMLZF463CcYmVDDL/Yv2Efy9kGayFIEFXmgyh86EL8sZ42qUVBPwHj
         wqkP6WzozokHkCI0PBlkxy5zaidJ9IBQL1Q9pCGCmo5IdceGlfxIM8ZIK9qxAltOuB
         wj0tOKTe8lNG8GKoC1BD9vj8DpWZsSmWXJNSay24TZTGR+8GFVl8B08TqM6gi1OyRi
         81VHRPAmNkfKIw3KWT7qiR2qs+IOKVY0Va4iWVHp3KQOlFQMD7gUsG/w5hXSOSzGx3
         uK4lyDgiCIWFcBcG/tOab6tNicnAQ6OVGfjiU7SzCvALcr624SqVGUOnKFWQjVfmUV
         Rh64KWxtJjDZw==
Date:   Mon, 13 Dec 2021 11:24:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: at_xdmac: Use struct_size() in
 devm_kzalloc()
Message-ID: <YbbgCFPROa8tmeE6@matsya>
References: <20211208001013.GA62330@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208001013.GA62330@embeddedor>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-12-21, 18:10, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version, in
> order to avoid any potential type mistakes or integer overflows that, in
> the worst scenario, could lead to heap overflows.

Applied, thanks

-- 
~Vinod
