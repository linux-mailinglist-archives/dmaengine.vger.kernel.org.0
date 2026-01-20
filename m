Return-Path: <dmaengine+bounces-8395-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O4qIllscGkVXwAAu9opvQ
	(envelope-from <dmaengine+bounces-8395-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 07:04:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E60FF51D87
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 07:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1882B6A788D
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE5242EEDD;
	Tue, 20 Jan 2026 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZJENXM3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F942849A
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913561; cv=none; b=erK1NZD3kBDfdJ7qUZaNNqI3TXILjHTykuvarF+1sz341zKl6+4U7JYxjOxnrRD8kRD5ejz11DqQequOgciB/suYR7jhdyXHXdCO5oUEAywWeajqN1JnSysO9KDLLKdMjOnf4gGiVus/1rudzYIywMte0EVMzJfDOPbRQxV8i4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913561; c=relaxed/simple;
	bh=VFvvzCPVMppU9YZe/NAS6ZVyOvp/Aoa+1BRn4/TUYGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lj6X+MKzbGbYBLbS/WcbcQg3q9+BFyEPy6Xp/AmNIGnHrI+p7XWn2FR0MuahybISJDBZwDFFKeCs1avrmbzx7HbW1cHQOgUjh3OA4kdBMHd00jtshpHxnQTR2ADtbry5h4LDprNkXKMITTofkdZ5YQqjpmyJbEvaXixsST94BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZJENXM3; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8718187eb6so815188166b.2
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 04:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913557; x=1769518357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN8iJ2c4mGSzLhHXbqnnydUI7yMc6vZwoegrLK0Ce8U=;
        b=DZJENXM32XvUP+cXKxMScacTdq0w3VJnAPQGJVqr0gEiMZ9UXAtqy6PNbatrx3xAAg
         aj7ou7CmkmCAmtftrDGgrPuV7KREPCTsvxEddaYY+TnaFZcr08xqgHejH7Bbu0/C5zpY
         eUoeebGi29sS/vGJ3ZKNlfgp9r4Jv0ugX/v1AexX1uRMB/fHnFeqr4zMLKhJC6yjiF39
         UhLSjE/5aejcvP/iGoPKZ+05n8y3U5VGnXid7ruXr5LF4SY2GvhtLP26kg+8FdBcmru6
         /AY7ADAECHv2HlMMpOMOBikqLgH42t4oUrK+z+Ecx4gjIgrB6JiDbeVHiOfjmHMcowhs
         lysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913557; x=1769518357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eN8iJ2c4mGSzLhHXbqnnydUI7yMc6vZwoegrLK0Ce8U=;
        b=HjDXK42LnHW0wtNrxrZWYcxVkjQAtytdA+I3NxCYzvWDLaXkpJdwiR5XWnG3FaMW4h
         KkkZUx8MjYYJUZu4DT8W8mZuFhUs6Dtip+xiRDLUi6HSI0YWuqSg22b3504WGVN8RYlD
         og8w2INdL1TgACKQl3ME4kX4biFvJRGFw2DY5GIINAglMbyzLbR/w/QDh0ebEQdvoa2s
         5r38yN5RsvX+VQ4WVYXA8QoZ8f7PYy/9asE6QM5r1oH/YuQhH4a46uYoueQKxIPCBZnE
         XHKbAF3PpEHFL7MMY2+lOjELMFm1SW7Pqg3qKRrHZOKXNwYiI+KZHcbbwG+14i6A6je6
         ywMw==
X-Forwarded-Encrypted: i=1; AJvYcCUDEdW1VFUed7FHu+lqXeTcVOkxrFd+MfqcT5PlTYEB16URzXSlToGQAvusXMO1l1zjYwilZegpNiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRsoYOy5r8Xvr7fdkXsjm8P7zQWVdoG2vjnB4dye5a4GrV81O
	agXGKpIDv7ITR0VXDeu+bZewwLZ4Yj1tIzk7bQQpnzvuhNuVPWXnrIiCwnjlpyTa
X-Gm-Gg: AY/fxX4N+zxuwE8s3K2JmnfLexfUR0ofB7NAtdPAiUcTRsFIZD1yYQqxHFH0l5nlNWO
	Kb0k5oBQs2heAIv2t0CMFVNzQHzgE5zxDUZLGGk0a+Ev+SrUmlUiz9B/OVpI852iCLOmS5A3t1g
	L1jpG5tULyfzgOKob3A/48g0Jb74hErFc26T58CSySyqEOxGBMdmEbdZQKDHVv+Hm0UspBxwpG6
	fYG7R4oytvvzsQWSgKUpqSVjP31E6NADyvvgkxyBfo4Gc57Jf6ZIQnSfQKQuXoo5cGHvPBE/Mgc
	qcmKyRBX1ushIHPHM+N1UmM8fp0A8KXpHVGlQMMANgtSIoomUOVO9ZSnpRmSuUROxuPGvFZHT7c
	JSr7DCPZqdC0ynRXSzP54K1/9E8/4NoXi7cVYTpRl+IPN6RwXQ3FG1f7VBizxafPbNHCIfiqpPe
	ULaMfqVerFPCPAYSIorRVWPHbgdjahLLA1nXs=
X-Received: by 2002:a17:907:e114:b0:b87:be08:815b with SMTP id a640c23a62f3a-b87be08844bmr596030166b.27.1768913556604;
        Tue, 20 Jan 2026 04:52:36 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:c8c7:2ef6:8ac5:5556])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959ca32esm1420626066b.41.2026.01.20.04.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:52:36 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 02/12] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
Date: Tue, 20 Jan 2026 12:52:13 +0000
Message-ID: <20260120125232.349708-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
References: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-8395-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,dmaengine@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,renesas.com:email]
X-Rspamd-Queue-Id: E60FF51D87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Document the Renesas RZ/G3L DMAC block. This is identical to the one found
on the RZ/G3S SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index d137b9cbaee9..e3311029eb2f 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -19,6 +19,7 @@ properties:
               - renesas,r9a07g044-dmac # RZ/G2{L,LC}
               - renesas,r9a07g054-dmac # RZ/V2L
               - renesas,r9a08g045-dmac # RZ/G3S
+              - renesas,r9a08g046-dmac # RZ/G3L
           - const: renesas,rz-dmac
 
       - items:
-- 
2.43.0


