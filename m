Return-Path: <dmaengine+bounces-83-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67257E916A
	for <lists+dmaengine@lfdr.de>; Sun, 12 Nov 2023 16:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8881C203B8
	for <lists+dmaengine@lfdr.de>; Sun, 12 Nov 2023 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8D14296;
	Sun, 12 Nov 2023 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDQimoD7"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28514288
	for <dmaengine@vger.kernel.org>; Sun, 12 Nov 2023 15:29:45 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D626A4
	for <dmaengine@vger.kernel.org>; Sun, 12 Nov 2023 07:29:43 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d13ac2796so22361316d6.2
        for <dmaengine@vger.kernel.org>; Sun, 12 Nov 2023 07:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699802982; x=1700407782; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzEQZH9R0t/Bapn1f5f6ajXZtSVpYGE27W0bmAfXRxs=;
        b=gDQimoD7/SWxzQ7MOemWc8kF03fM5d5nG9dTfShPVVx5JKRp0tmRc/fgAVLk6Hyv0A
         XvfxFpQj8IZzeqReKJCTVOGWwI91VwXmZ1ghbtbR2sKcQyqEH/wHllEbKSIqacWMTBLU
         vfI0MC8rJ1+X1K3a9xjvVrRpCJ8MryQgD6OqY8fqizIce73J5nvqtKyv6unxYs/5KY1V
         kSBRpdEwGZsFq5daV6jHuAkISHJdk70lSh3cfhjplbQvgrDLPjXiUh0bMnVt5U8cfk6W
         d8VK81Iu65IrQsF3BYJUwpdWTiGfk8NUWAg0L5KJ+Npy1bnHyonD2TlDqe4+uecegJoZ
         Wveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699802982; x=1700407782;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzEQZH9R0t/Bapn1f5f6ajXZtSVpYGE27W0bmAfXRxs=;
        b=YtQNRYTE2hg2MiJbkWaP1/SlF+DwHUFSrz6Fp1pDttTNauZcSLabc6c3L1aq3uDzox
         7lEpk28jkLxZ6Svif1aKzPphcHvbq+0T0u2+mS3yWMrUIGN17Dr199lPzDPxP63blASz
         jcFp39cmpu03cWOFC2rzACkvG3ES8TS7Usfwgs6ewjf8EJ2tnyCYn9+tMWIchUjcdXQ3
         XqFl6j2gQOLaLv6sjbezJmdDgngEN9N0moCuG4D7uMEyt1YoOU1sC3Wv95GpcbMarkVT
         WVnsQY71tVe3WmHDVEVOts1vSYJpRizrdqLdV8ROXRH8N9zDHx3a4XLl0xfCzsDgklGQ
         L4/g==
X-Gm-Message-State: AOJu0YxbcFzIcDoY0yhREGf+VC8GAPo7oyVwS+nPrrcHbVRVlsDDqEki
	qDpYTtc7OYOS0oR44VZu21pVTcRAoc4=
X-Google-Smtp-Source: AGHT+IEdO6H6PdMWySUuxOlnfjUXjSKHspIk3/oUR+NPCaQkxxNRmGB6CasatQDZkHv0sVvth9km+Q==
X-Received: by 2002:a05:6214:205:b0:64f:6199:a8e with SMTP id i5-20020a056214020500b0064f61990a8emr4217957qvt.23.1699802981920;
        Sun, 12 Nov 2023 07:29:41 -0800 (PST)
Received: from [198.135.52.44] ([198.135.52.44])
        by smtp.gmail.com with ESMTPSA id h3-20020a0cd803000000b0066d15724feesm1325463qvj.68.2023.11.12.07.29.41
        for <dmaengine@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Nov 2023 07:29:41 -0800 (PST)
From: Peter Wilson <martin15wamburu@gmail.com>
X-Google-Original-From: Peter Wilson <info@alrigga.com>
Message-ID: <9b2b733f2261c7a36a14b83fabcf240be7801b0d9d6ec24fa5b96fcd58a818fb@mx.google.com>
Reply-To: eurinvstacc@gmail.com
To: dmaengine@vger.kernel.org
Subject: :once again
Date: Sun, 12 Nov 2023 07:29:14 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Level: *

Hello dmaengine,

Are you Thinking of starting a new project or expanding your business? We can fund it. Terms and Conditions Apply.

Regards,
Peter Wilson

