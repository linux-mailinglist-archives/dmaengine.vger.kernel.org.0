Return-Path: <dmaengine+bounces-10188-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNO1BLh/8Wk2hQEAu9opvQ
	(envelope-from <dmaengine+bounces-10188-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 05:49:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3DB48EC68
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3523F307585B
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7780538B154;
	Wed, 29 Apr 2026 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMEZ7Wx7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434A313545;
	Wed, 29 Apr 2026 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434413; cv=none; b=NlUBxQwz+ZRtBADmKf0t3NxCrCs/5uHEef/P3R9zKseSaDvg27D3v4kyp/iZueITF6Gi8gQmg2Cv6b9Bac8/1NwaA7a9hmcMZT0xn2OXOHAwquEUMozRrj4LWkFIUmVJkYu3Jd6inuS1wqPIlphTxA+dFUyfmhFTgy3Ldd6QwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434413; c=relaxed/simple;
	bh=45IZZlvy5m8D36o9FxaXN13xt/oU1CnjDv56aCuJzOw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=M9FxtHUPHmFN5oJg4JM+yNbRqZgBR+ioV7UPSJdDqWto7+CcT81TDUfLIt0ZsN9SUdPItSaq0crsWye5PaiCeqljwXSoOXRk1/tSOP7CuQcpGZi3EmjzQdMvHtGwV9WI6LQM96R1+WLSQ3Ps98PgeHn8zxk9F9RK8awImM6JjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMEZ7Wx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285ACC19425;
	Wed, 29 Apr 2026 03:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777434413;
	bh=45IZZlvy5m8D36o9FxaXN13xt/oU1CnjDv56aCuJzOw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CMEZ7Wx7i3JLG2fPGaPVomVTVfvffC472xgvjoZrpwaNiVAfRiOHWTnWFVnRWToVE
	 hays5e0R4dTqkVq1BdIET7Q0CVhsHHzduG/KP1ixv9tcV2kQaXXv64ubYqSh1qtNdi
	 861p4mBw9gtSA2PVgMXWb9E58QtUPGh/M0Ks+MCrBxJZXEmzk1VC3Uf6QTZJjgWrXN
	 nthuhbNW9cKa+Srv5wUooxyoS1JFoV91HgxBhPBi9JqkAYlPAeHaISRCxd4vjhqk5A
	 4YQ29V/6m3R6VE6mHMBpuG52yP71wFK8HTKEmENdI95bSrNTSXJiumKyWLCax3x+Gh
	 bbttZw/UW+eYg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260424-k3-pdma-v3-4-efdf2e414a08@linux.spacemit.com>
References: <20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com> <20260424-k3-pdma-v3-4-efdf2e414a08@linux.spacemit.com>
Subject: Re: [PATCH v3 4/5] clk: spacemit: k3: mark top_dclk as CLK_IS_CRITICAL
From: Stephen Boyd <sboyd@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Brian Masney <bmasney@redhat.com>, Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, Guodong Xu <guodong@riscstar.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Rob Herring <robh@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, Vinod Koul <vkoul@kernel.org>, Yixun Lan <dlan@kernel.org>
Date: Tue, 28 Apr 2026 19:03:19 -0700
Message-ID: <177742819927.5403.12105832893857014560@localhost.localdomain>
User-Agent: alot/0.12
X-Rspamd-Queue-Id: AA3DB48EC68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10188-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sboyd@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacemit.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,localhost.localdomain:mid]

Quoting Troy Mitchell (2026-04-24 01:20:32)
> top_dclk is the DDR bus clock. If it is gated by clk_disable_unused,
> all memory-mapped bus transactions cease to function, causing DMA
> engines to hang and general system instability.
>=20
> Mark it CLK_IS_CRITICAL so the CCF never gates it during the
> unused clock sweep.
>=20
> Fixes: e371a77255b8 ("clk: spacemit: k3: add the clock tree")
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---

Applied to clk-fixes

