Return-Path: <dmaengine+bounces-784-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A1836D06
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EA71C2689C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF7537E1;
	Mon, 22 Jan 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYZ3Fdry"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44652F9B;
	Mon, 22 Jan 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940710; cv=none; b=YLKGtaedNDpL/ijI0AVufsaXCEdAGXRyEANzG+J70zx37bbMYeG6VMAFcfLfVInhg8F6xxaZpYg5Vbl8L6ui4yiU1kk9iYqwaFVbZ2PPxpiypTdPbO8g/TwW7QBekD0GV9Hwr+fLle0VUJx9m99pqO3oRmBqorrnaZdlSlPloG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940710; c=relaxed/simple;
	bh=igXbIkIM8xN9+HMA9lcAo+iomvB853mlzRBRtZLgO14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QhDw8ZuGtlHqNKpWs9NnhRFldJyQapoB1il1VyFHn0YC8moln483IvQmvNaaZKrdLMahnUWYElED74nUJ/QCmzgXaZuqGgjHSOf1MVZKosgfUBFQgXOyStEI+1S5P1QFnbn2YAw8TZJzayCL98bYWpx7e0BpKYVlvrVt0+50l3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYZ3Fdry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04B3C43390;
	Mon, 22 Jan 2024 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940709;
	bh=igXbIkIM8xN9+HMA9lcAo+iomvB853mlzRBRtZLgO14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JYZ3Fdrys7o4jSjv9npFQM7OLGD+5ZwvJohEV6AAWxaeAJl6rDNtuaFj5jbAV/KHK
	 Ocwh6i60glbgtcD3BPiFoLfi4ew4Z8ouPcn7PxTs+Nbo5mRQuKf/sqLaLhpbn6s3RS
	 IyK5n15W0Ay4kUY6kQgGF0jlnGp+H9IqFFTbyvRjS2zB2GHVYgmLKtcgLTF06BiCan
	 q13JvzDzovKu4oalt9zXkSgU87pesEhuuydo+b1frGRyLmXpFQgy2pKhE6WSwDbwER
	 QrKOI3Pd/3aOvb+xWxOIfD5l05mggaI1V2o0bieROZjNOjipFrJMicYA3jdYkkLhtd
	 dtyVP3PNDn76g==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, Jai Luthra <j-luthra@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240103-tr_resp_err-v1-1-2fdf6d48ab92@ti.com>
References: <20240103-tr_resp_err-v1-1-2fdf6d48ab92@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Report short packet errors
Message-Id: <170594070741.297861.5504433996830507557.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:55:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 03 Jan 2024 14:37:55 +0530, Jai Luthra wrote:
> Propagate the TR response status to the device using BCDMA
> split-channels. For example CSI-RX driver should be able to check if a
> frame was not transferred completely (short packet) and needs to be
> discarded.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: Report short packet errors
      commit: bc9847c9ba134cfe3398011e343dcf6588c1c902

Best regards,
-- 
~Vinod



