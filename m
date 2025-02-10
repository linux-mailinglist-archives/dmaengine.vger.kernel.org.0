Return-Path: <dmaengine+bounces-4402-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F00A2EFEF
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F23A18890C4
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C123F280;
	Mon, 10 Feb 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9tenBC4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0B23F26D;
	Mon, 10 Feb 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198130; cv=none; b=JKIW59NGFfcAILdro1jDXRBDRJM9x3f39UVrBXcliIxbdU3jJbn2Va90TToqIe6XhsDkEGf7awWX6MJF080CzJFNQbZc26hEvUB5Ilh6D4N7k+9pz1CHhGoeZ4TLvSohWmcKOQtfX7lCnNXhiy09TmgiYZpKGufWvwcvxM7N3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198130; c=relaxed/simple;
	bh=tuVuNfMKOoC54+WO2MX3n88naYhRYX+tm4//Zfs9eH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jH1BHgZqjiEND/w+UMLFCNkGn5Sy5E/VdbBM9GKeh+yDgub5uuiFZ9xm+KXt0Ma6oPgpl6gd6FSfFqykGi0CPUuhWUkFCQW2n0WB+OMFwN2tNbS6jw0MdKndf5wK84V8ptSng0F11+Pmq8O+Cb8apZEixNDBb7r2EGa0uxbx8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9tenBC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4D7C4CEE5;
	Mon, 10 Feb 2025 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198130;
	bh=tuVuNfMKOoC54+WO2MX3n88naYhRYX+tm4//Zfs9eH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K9tenBC4my1OV7X3OBg5YCkih9en7WeakMmfBclpfKqnhS0GzcbDoOS9S3+1RmjZQ
	 Sa3Iwsl90CrtYVusY7FgpuJ2Q0bdlCmkNtXyQWsU9H+N7jLyr+5r53rwEcebcoJdiD
	 6cjFsnb04i7ub0FfeAkyBzAby1vDpji9Echg4G2bwHoCCTnUplg+XGeoYJBg+QdXgH
	 NVcOG9QPgEJ+Adp6mdCTJT4UYWua98ELVLnu+cMdYNZaF4HbF3oQFNiAEFRLirgktZ
	 xlWSaifJy5YABM+UvwFmN0wYkkwedCuM0SueLDCk+/QkYVJNjw2EUUGJQPJySnTiba
	 PqeTfaE+CBMqg==
From: Vinod Koul <vkoul@kernel.org>
To: Fenghua Yu <fenghua.yu@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <ec38214e-0bbb-4c5a-94ff-b2b2d4c3f245@stanley.mountain>
References: <ec38214e-0bbb-4c5a-94ff-b2b2d4c3f245@stanley.mountain>
Subject: Re: [PATCH] dmaengine: idxd: Delete unnecessary NULL check
Message-Id: <173919812806.71959.8861019758303939358.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:05:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 08 Jan 2025 12:13:20 +0300, Dan Carpenter wrote:
> The "saved_evl" pointer is a offset into the middle of a non-NULL struct.
> It can't be NULL and the check is slightly confusing.  Delete the check.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Delete unnecessary NULL check
      commit: 2c17e9ea0caa5555e31e154fa1b06260b816f5cc

Best regards,
-- 
~Vinod



