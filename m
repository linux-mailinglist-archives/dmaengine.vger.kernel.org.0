Return-Path: <dmaengine+bounces-1883-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495B28A9249
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 07:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08ED5281734
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 05:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1479B54BED;
	Thu, 18 Apr 2024 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQcziQ3Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1C54BD7;
	Thu, 18 Apr 2024 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417204; cv=none; b=nizGozTdJhJxESET5PAElcQDMhmsdOE48cONiVBnOFGxjOkeHKK4sQrXxIp3RJqNAdhTVpJ4JZdN57BWygGebf6woE9yxc1Fw3psYXdKkTEP6P5LJt5VlfTnd2Y2EegJ/RyErF8lXm/ulc4bzPkjlOxfP97P14YSsBYa6zTuQoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417204; c=relaxed/simple;
	bh=0raeEscXll/4+HdtEg7PnW0pfDkDbUwSjAxgQ7A9HuE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ORI36zdfH1QBspvV4t2MamT0sImFgwZwuf+ODvuUtrgc7J39YlieBPQobi0CBPGsBuV/waVQS/z/P+OPC6XOt09n6VGwBmhfWiouZJesk1GL6XN8CKs+WnyIqXhUNjQ8tEor9kiMeRd2pcBqCS6EHWGJb6oMyg4kfW8zwfk2eOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQcziQ3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213FBC113CC;
	Thu, 18 Apr 2024 05:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713417203;
	bh=0raeEscXll/4+HdtEg7PnW0pfDkDbUwSjAxgQ7A9HuE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fQcziQ3ZehDZXYqdJwYgX6jCypuULV7xB1ewoCZU1Lxnoyi4RUfumSv1n2rW9X694
	 AmuFacLtWwpv5UyNtITUzQZtbQeWYvpqa0xXVQyqlqkcrYZeWW4864NeOjTvTe4cGm
	 lWzuAVQ8WqdsMbg4YWq4ET2TdD+GT1FVnlfF9KznjiaxS4omhSraSHpl39tsT4my8K
	 zzNPQ0aYss34Rlcexrj+PgURrsv9QppFZeANiE80puKpkntjnslj0AD9p4n0+d/BnA
	 Y1mpnwcK59LEgboI5KOG0SFFY11H7xr4g/wKkUdXcnVBRCor1CDJ+6NrBIYOx/5JWv
	 Xozgqo+QAWBow==
From: Vinod Koul <vkoul@kernel.org>
To: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20240411203935.3137158-1-Frank.Li@nxp.com>
References: <20240411203935.3137158-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: fix miss mutex unlock at an
 error return path
Message-Id: <171341720175.758041.16850727320392721099.b4-ty@kernel.org>
Date: Thu, 18 Apr 2024 10:43:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 11 Apr 2024 16:39:35 -0400, Frank Li wrote:
> Use cleanup to manage mutex. Let compiler to do scope guard automatically.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-edma: fix miss mutex unlock at an error return path
      commit: b52e28eca7da47fa389605a8eda1952a9fa3c69f

Best regards,
-- 
~Vinod



