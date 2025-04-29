Return-Path: <dmaengine+bounces-5036-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE2AA073E
	for <lists+dmaengine@lfdr.de>; Tue, 29 Apr 2025 11:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2307AD5AB
	for <lists+dmaengine@lfdr.de>; Tue, 29 Apr 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03042BCF47;
	Tue, 29 Apr 2025 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fgqNSJz+"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CD2973A4;
	Tue, 29 Apr 2025 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918916; cv=none; b=PmL8NjLRpyLem+uNJDRLm7/tj4s95tpywbKnM1CKbWSzqhib6Y4/9DGxeUZDq0iNns3/FDJN344ipqoXKyHpPxNMkhErp6LdNQaMM0iBsFmZSi+CTR0hFFfrRCYbqU5sUeVrPxVUgcbsrPGwOhkwdyhhoGYzA1wGWmQEv73AqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918916; c=relaxed/simple;
	bh=6moffAOrVA+hGv+8Q+HkCEsMG3S7q+Bi8T6sOeCab+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5nPXlSXYFK+DDIvmvLsoo79yYe4Wmh+LUKmGF77vtQXuBrBUBeIvd67vsCREBdU5DR/RmYpuOCW/8oKWFoo1ykHf5pEk2+M6b1RdVM0sX+hTxsp6RakJu+LNC+Sk6UZJxpeph26mR2HYKCCG602qGHa4w4p1O7KNYSZpC+UBs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fgqNSJz+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDB851FCE8;
	Tue, 29 Apr 2025 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745918912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4kTu2R5MakUDhndc1hgGYZijHuY+tlguYELTfdps9M=;
	b=fgqNSJz+Fb7EfaULz+ZRr45/Zo+uofpKquNyLSMdLph65+f35SYob023GMz9HtQZ3/OI69
	CyrDeUAdOOhgwa4/OAdrzaP7P+CYVMiw8zgLb9KsrfHuyYOnZbus84InyFsz7LTFCAH9gV
	tYN90ac70V8L84ZiWaIkchC3ggn+7HJ8bD+5h0/cXIWkTbxqx47OzfMrzFxNSIGk5epadw
	mtA5U1xszQARp/SuKnMRuXcQtFHgMX7VpiuatnTUhasWIAYFwyTUb5lhDXegRg3Q8lgH5u
	OrEtwioS48njEj4UiJAm8ZQekDNGeBe89eAyiGzZQXGONglS61uEEfyYAQoxYA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	richard@nod.at,
	vigneshr@ti.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	agross@kernel.org,
	Kaushal Kumar <quic_kaushalk@quicinc.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 0/5] Enable QPIC BAM and QPIC NAND support for SDX75
Date: Tue, 29 Apr 2025 11:28:25 +0200
Message-ID: <174591886994.994230.13306860112856962284.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423063054.28795-1-quic_kaushalk@quicinc.com>
References: <20250423063054.28795-1-quic_kaushalk@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteeutdevudejvdevtdetueehueehgfetkeehieeuhefhieekfeetlefhheffhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledvrddukeegrddutdekrddvheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrddvheehpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghnihhvrghnnhgrnhdrshgrughhrghsihhvrghmsehlihhnrghro
 hdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheprghnuggvrhhsshhonheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 23 Apr 2025 12:00:49 +0530, Kaushal Kumar wrote:
> This series adds and enables devicetree nodes for QPIC BAM and QPIC NAND
> for Qualcomm SDX75 platform.
> 
> This patch series depends on the below patches:
> https://lore.kernel.org/linux-spi/20250410100019.2872271-1-quic_mdalam@quicinc.com/
> 

Applied to nand/next, thanks!

[1/5] dt-bindings: mtd: qcom,nandc: Document the SDX75 NAND controller
      commit: 2cf4bc06f7008fe3eab4b27d7c0ba9ba08f5dc5d

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

