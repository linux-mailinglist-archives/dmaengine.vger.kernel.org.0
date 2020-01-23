Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA21466D1
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAWLf1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 06:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgAWLf1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Jan 2020 06:35:27 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9BF24125;
        Thu, 23 Jan 2020 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579779327;
        bh=izvZuwImB3GgfCiGqIjOGun3WeYdSpQvEwdBkmy0m/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2qH3LgwDIP17Bj3NnZYz9WhRdGYZN/Cg6wLQ16qKQj6ZoVLcofKlD39gvGT0ChX/g
         vdU9FKReNNCbZRx6stcAxVKYS6HvOniAxpHd+ImpVAyr/g/iDlvygTpxGyoa4ee3RE
         iXMOkDy9uEQFnBPurv2owJQFVUZrKUcvxalFu4IQ=
Date:   Thu, 23 Jan 2020 17:05:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fix spelling mistake "to" -> "too"
Message-ID: <20200123113522.GY2841@vkoul-mobl>
References: <20200123092359.10714-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123092359.10714-1-colin.king@canonical.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-01-20, 09:23, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message. Fix it.

You had sent this earlier, I have picked that one already!

-- 
~Vinod
