Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0801D117F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgEMLhp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 07:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgEMLhp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 07:37:45 -0400
Received: from localhost (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33EF7206D6;
        Wed, 13 May 2020 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589369865;
        bh=Amv7ClRMH2P+UI3l2B5270/ACCIOxjyfdce/BpqOoTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mfre/YeCy6QGwcr1Joz5kiu6wC7c9bN0saDvow8+/oqfy5oYhM7+lYCakrlu0p6f+
         GuEIUYwThHzDzmwTRdutNYrqWaRKyn5f4Go1mLbAheINq1UyThfjbnheN+l+s+Uo0i
         0CWuIQde9tkxBvs2iFZw3a44LaQecEgQcrbOX1VU=
Date:   Wed, 13 May 2020 17:07:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     green.wan@sifive.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sf-pdma: Simplify the error handling path in
 'sf_pdma_probe()'
Message-ID: <20200513113741.GG14092@vkoul-mobl>
References: <20200501100824.126534-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501100824.126534-1-christophe.jaillet@wanadoo.fr>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-05-20, 12:08, Christophe JAILLET wrote:
> There is no need to explicitly free memory that have been 'devm_kzalloc'ed.
> Simplify the probe function accordingly.

Applied, thanks

-- 
~Vinod
