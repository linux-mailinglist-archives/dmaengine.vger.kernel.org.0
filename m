Return-Path: <dmaengine+bounces-1983-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED7A8BBB8A
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 14:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509D71C20CF5
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2042135A;
	Sat,  4 May 2024 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dECQiKYS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4E4A1C;
	Sat,  4 May 2024 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826838; cv=none; b=g4mxUIAvM05wyQly67BZb8aDH7hxy/rVzs/YtHcB4NvNVftvN7lU9aaenzBXoBw2s9iR5deqgqdKK7VjpiIKANFlkR7lcQvQjvq4xKpZ8QM1TCTAsxiQZlmUszRdWufHGQHhDYAhL0dUMpRO5ikxgZxL3A2fWLxbc4KiFEgVpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826838; c=relaxed/simple;
	bh=pqt4smRG+5GybQjA6EDoHDsoEsSsIw8WFxe/LSzKYEc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rn6LDIOwvScF7WyA9RynEXtDs9zT9piSR+DQfMiu4HGg4u6ndBF5YgLhSjHIShGuj1FcqCP/7fH1AYF4FqYNQpF286+8UcScFPylDdeBmSzpk759JSXjuq/wLn1jBDXwTxbHN4A/PPHvYxS7QJnvJ5PoW5rICjbPcQ/Ry/RAUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dECQiKYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E91C072AA;
	Sat,  4 May 2024 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714826838;
	bh=pqt4smRG+5GybQjA6EDoHDsoEsSsIw8WFxe/LSzKYEc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dECQiKYSEs8riK5ARRXLe07H4rxQwTdCV5Dt+wU3JnDUUT3ZVVJ0efwyIbc6Ujzf1
	 YQbaAxU/bBhDIFaXtxVtqr2qyzftsllLkJ6/OnVpjUIDSVp2VRLTptPSyqwj3N3t7M
	 yUoWHzXE8YAGBWTgp9OpREjPB4jVm9WlNgfR7grzLncBYxgQk8eHrB070ijPlpEc/x
	 ZdIzRCZasjjEICeX9Xv0+ozqEQ4K++O/dEMjvxCry1VaA5Si/iufI4CH/aTAKlbSPg
	 CrhsO2TD6ndgpEBqhAZzXjJWKBNDlGkuIAcujM+VnpMvelSnDKlbrxpe+jbR52jxOr
	 okzRfDZsSFHZQ==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, 
 Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20240130013954.2024231-1-fenghua.yu@intel.com>
References: <20240130013954.2024231-1-fenghua.yu@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Avoid unnecessary destruction of
 file_ida
Message-Id: <171482683528.61200.11644725480487646401.b4-ty@kernel.org>
Date: Sat, 04 May 2024 18:17:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 29 Jan 2024 17:39:54 -0800, Fenghua Yu wrote:
> file_ida is allocated during cdev open and is freed accordingly
> during cdev release. This sequence is guaranteed by driver file
> operations. Therefore, there is no need to destroy an already empty
> file_ida when the WQ cdev is removed.
> 
> Worse, ida_free() in cdev release may happen after destruction of
> file_ida per WQ cdev. This can lead to accessing an id in file_ida
> after it has been destroyed, resulting in a kernel panic.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Avoid unnecessary destruction of file_ida
      commit: 76e43fa6a456787bad31b8d0daeabda27351a480

Best regards,
-- 
~Vinod



