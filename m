Return-Path: <dmaengine+bounces-10713-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mb0FI13D2pEMgYAu9opvQ
	(envelope-from <dmaengine+bounces-10713-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 23:22:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC8E5AC19B
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 23:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96C993021B2D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D62F99B8;
	Thu, 21 May 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK0AAIZF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98252BDC29
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398537; cv=none; b=Qhusun3KREQdsiVXKdsmHY6ezddDB9rTIn+88cHzcwLy0Fw9fogp5/m4V4x7yLV2VUFWVq7hrsBIkm0lchL0Mm0J4dOJ+MM48sG/SCz364KaZcVJQXFmmz1lobgy+JLo8JYmPGuvInejkAEKBpsrfFgxXzoVCETLxtg92jrPcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398537; c=relaxed/simple;
	bh=tnHXTr9FKZWeKp2C6XnlPZdelHbA9EjSIlUMO5BVtjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfuRVq9VpdfFfZ6gvy4VamxqBraVLi9ttFyu+Ri0zEBS4s7VlvZGhlNS9WiUMG7ACPPhxvI0bBEcr9sh2/3hbAG+gl3CCliEk55XB9GKjlB6VC8MsxZSefUBKyff/BKZ1FhrGUPND7EowHJ9EFbmV/UJ99lUVKwA/02D/VIqbG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK0AAIZF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49040362e4aso4789515e9.0
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779398534; x=1780003334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnHXTr9FKZWeKp2C6XnlPZdelHbA9EjSIlUMO5BVtjc=;
        b=MK0AAIZFTNWH7+x6uSQFK7lKetw1klAQ3UYkbpFZcF6m72Vu3qmFL7V8HvxylzBwR7
         asusl5TCU9WE+rWXDfwTrqI3GD4GFj/uzKPSqQ3rvzblTYa4sBhPvPaU9rzRhBIobVQg
         Bragb41kF8Lmw03bg0N6y5QCuZP7QT7lrHHMC/D48hFfGjGUZWyMxnVbIR87x69my6rK
         Sxdo8H8yl2pqLaM+qnRqJ9l+XLhrP4gGlXSBsbxG16U8YBLsJIlc4AnOreAtDeKXHkDB
         VHiZYCXkHHZI7lf/EdwG2Pb8kYnQ7I4g4MFWrWflr0QpUXeppy2bXYxE/ae/Wiv93hah
         Rn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779398534; x=1780003334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tnHXTr9FKZWeKp2C6XnlPZdelHbA9EjSIlUMO5BVtjc=;
        b=VH5wvHs59d5vrXAyB+0WfIh0l1Y4Tac/ZDrSN3JzMjKIPIVHKeVM5jMPDBDwvGIfnq
         ObXd6SsjZA7aqpeyfyxTpz5XavzOt2g5apfT8ZerscO2KI2H9Fl3WpHCL8mu4W1dLcq4
         dADwxcohWyVvRyn6bndjoUOtXLJ5YuOnaOA2D9/RfXhvKuQg+YV31R7+myEp45wAb4+i
         1dUi+dfN0zRRFhBT3zVY/XUzOa//36hAXG1cD/uF+v4IjVYB66TPtzI1jqQdFhMd+7Pb
         BS5I1CNr/6CMPrDQs/x7sOC+nlworRbL7K3Wy7kfScLZ305om4UT3/4PLoPYVhDFAghk
         kdXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EBaNfHZx9CurkrxHVzZJsEthgP6cV6WdmsZGKRO3DuR7hO0NOlxnDr9Tl+iS2+AwidOYfJpIckZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwwBBCregRnrhWqwP6hNdGkZ8KGxrrQuFL1sQ+1sZhag65XPn
	Sbh1IqO03VFlCf++8OmoMsy3ALmKcauXnp87x1OtFKcyR8UEsIfaN1mao+fRjQvJ
X-Gm-Gg: Acq92OFOionWHGf9vq6hiYMM9B5Blyi9VVjrqfOKJHuH4xy1jhMAKVmVgr8rNHnS8q8
	btbjPSx7zpp7/YW2ThzOswG2wEpJZi55kTQNK1wF3stQdfxUFDrqe2LoiThw70y+Tnl3SO7e6F2
	kEwmLN+yl7yq4JZFmlx3+P4f6VavngaZenkkFTwwCNPmlqiu4hg6E1vBE/iN4UWfJDpQALIAeQf
	t4g3oFLnCqQcEB2kvFqNA8fitPnUHDh1fiS66KP+fFmK3Hj3QOCGpV1h/7VKs5EhhNGvTDVIeqg
	TP9axrh7+u42z/UvUGJtlSeUNKB01F6oP2hE6CIkf2j9DdZMavfkuy+KVJd6d3tfStIZgnlXUdU
	ZMLf/372Cmv/KtLuMRJZV8ihJdwXu0KnFNPTJ9xBNEI/ebdCOp98ujyVVY4xsLrSIB5ws1oHxUj
	3LoeMqTFBjEf8Lq7vLH7faWgjn+Z+lO2y7Z2q85BorND3oJ9rXZ83ioiizvZZVSzbRU8ED+2jao
	pKIx2oC96U=
X-Received: by 2002:a05:600c:470f:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-490424b61admr5406585e9.13.1779398534266;
        Thu, 21 May 2026 14:22:14 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb4977c97sm43043f8f.13.2026.05.21.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 14:22:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: vkoul@kernel.org
Cc: kelvin.cao@microchip.com,
	logang@deltatee.com,
	Frank.Li@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: Re: [PATCH] dmaengine: switchtec-dma: fix FIELD_GET misuse when programming SE threshold
Date: Thu, 21 May 2026 22:22:11 +0100
Message-ID: <20260521212211.21942-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317083252.13224-1-devnexen@gmail.com>
References: <20260317083252.13224-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,deltatee.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10713-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9CC8E5AC19B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinod,=0D
=0D
Following up on this one-line fix. The bug is still present in=0D
linux-next as of next-20260521 at drivers/dma/switchtec_dma.c:1102 =E2=80=
=94=0D
FIELD_GET extracts a zero from the 9-bit thresh value against the=0D
bits 23-31 mask, so the SE threshold field is never actually written.=0D
=0D
Original posting:=0D
https://lore.kernel.org/dmaengine/20260317083252.13224-1-devnexen@gmail.com=
/=0D
=0D
Thanks,=0D
David=0D

