Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE422C2E9E
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbgKXRck (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390791AbgKXRck (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 12:32:40 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175FA206F7;
        Tue, 24 Nov 2020 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606239160;
        bh=nU90RZ0/AaWOqQfZfgkoc9ZRMkWglboLl418mf0d1K0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upNz0hCshIHqlnMJATWTPK2bML0UIKUbDGkY3Fc+bFxs9pX2rkpypknzA+m6ynoJr
         UWWN4MEB++SxiPUbfaqgm2I0iYbKdJcsQrHQP4f9WvGhV7L8WhYZd4GDDbYey4KIZV
         JgilztChOb75WDHqL2S76XuMpdeFmTjBYU43rujg=
Date:   Tue, 24 Nov 2020 23:02:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/6] dmaengine: jz4780: drop of_match_ptr from
 of_device_id table
Message-ID: <20201124173235.GZ8403@vkoul-mobl>
References: <20201120162303.482126-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201120162303.482126-1-krzk@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-11-20, 17:22, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):
> 
>     drivers/dma/dma-jz4780.c:1031:34: warning:
>         ‘jz4780_dma_dt_match’ defined but not used [-Wunused-const-variable=]

Applied all, thanks

-- 
~Vinod
