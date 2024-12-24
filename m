Return-Path: <dmaengine+bounces-4068-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF99FBCA5
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E8A7A2C49
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395FA1B6D1E;
	Tue, 24 Dec 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJqtfLnv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F81B21A7;
	Tue, 24 Dec 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036940; cv=none; b=nNFBQ3Vt3LJHc2lSr3Djw7RhHR41OT6zeFvwqazpn7xZoU5JIgVece7XWTW5TEWdjuLJDIAMUnGtKRlu87vmZ4EiTgPmOEoAJ8MMJwByJhv1VKE43N+VC/UosPZlyiSlnSM15VF4ZFTFtCBhz2liW5O6loNUd1QpLtH5V775hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036940; c=relaxed/simple;
	bh=BAUliJT9kLzkf2+b4LchIUPUbkfug6p9P+6FcmRP0K8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G7MiVHl777WmRX+qIZ/Lpjj19as38lNRB6WdkSjlHLfzbxbPZJmOOx3j9fwXuSDB2FPYMRbKeZxFOiQpWbnJ785g5VENx+r8q0sC4kjYkhbEnzWIsFgehoG2CcRw90XtsZ+UqkVDs6LxEwWawOH4e2yOXNqHcZPVJc6rZbV0vY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJqtfLnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E574C4CED0;
	Tue, 24 Dec 2024 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036939;
	bh=BAUliJT9kLzkf2+b4LchIUPUbkfug6p9P+6FcmRP0K8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qJqtfLnvRFDkD/wby3x6X3xQA/m+RxEHb1gUgY6a5lYvyr0PvEMkGbSQufPYEQN3X
	 KO8jGR2zjaorcA84TtdZQnzJ0vwGc7V2342JDfoyfK3V6YRiCI5pCK+bfp/Zaej795
	 tJbINlcIKi7T4BYHC1uL7BIfngCZZwwykeSYqGe9NDbMys5xmets2FUHvtUZTpuKwO
	 ldPPVuO8NNIAYikXAefW4nZw+vikbS4SXUvOod4ssyZiHBr+6MjprqstcqsDr2VaqO
	 DpMZHivkzt8Gvp863Ima+YRpJrCoP7nfk2372UMtQQE6GDnJb0LtnezMzDPRtdqJhp
	 d44wWs/OGz3Og==
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241011-dma_mv_xor_of_node_put-v1-0-3c2de819f463@gmail.com>
References: <20241011-dma_mv_xor_of_node_put-v1-0-3c2de819f463@gmail.com>
Subject: Re: (subset) [PATCH 0/2] dmaengine: mv_xor: fix child node
 handling and switch to scoped loop
Message-Id: <173503693779.903491.16509024462497085672.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 11 Oct 2024 22:57:58 +0200, Javier Carrasco wrote:
> This series fixes a wrong handling of the child node within the
> for_each_child_of_node() by adding the missing calls to of_node_put() to
> make it compatible with stable kernels that don't provide the scoped
> variant of the macro, which is more secure and was introduced early this
> year. The switch to the scoped macro is the next patch, which makes the
> coe more robust and will avoid such issues in new error paths.
> 
> [...]

Applied, thanks!

[2/2] dmaengine: mv_xor: switch to for_each_child_of_node_scoped()
      commit: 9f6caa3978b0e859da39e4ace7973b877222dfd4

Best regards,
-- 
~Vinod



