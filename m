Return-Path: <dmaengine+bounces-407-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38788092DD
	for <lists+dmaengine@lfdr.de>; Thu,  7 Dec 2023 21:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50811C2087D
	for <lists+dmaengine@lfdr.de>; Thu,  7 Dec 2023 20:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1E4F884;
	Thu,  7 Dec 2023 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9c9Deq4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178797096E;
	Thu,  7 Dec 2023 20:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973C6C433CB;
	Thu,  7 Dec 2023 20:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982761;
	bh=C21rcvb5f90zCPP0WfTqfPYIWbLBcAu22m6JrTOBcPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X9c9Deq4Hu5p/+2MCzm19VQNajjN2p45xeo1yF7xkiwC8xz2rGgTxZKv9UDEV9lEb
	 siIg91bqWQA4fHnQVZOK2B7hf/39/siATgl+J3rRFiUJsWkcgFWFCOaQGmOhDyuMya
	 FL3gO7HQ7jsVl3u3zvXSDonLQOvufh/6NS4OYPpI3QlxUpu0MoqmWpOZ2A0pNuRBhB
	 wXAPihB46OwvR1QYV98BwbuLm5T53dglI6vavT1h5tNQkpStpWXetKA5KBdlGg8+Rc
	 yPNQOdWnssXrC/7hv2UFw6f5Sfhx0++xDoXxlx4f0jZhtjCpWuftos831wvIhrRVFZ
	 Iq7jopWWvc4bw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50be3eed85aso1657854e87.2;
        Thu, 07 Dec 2023 12:59:21 -0800 (PST)
X-Gm-Message-State: AOJu0YzoBQWw7K+JV09lUNmIwHPMlnpQUWTdnW4ZMNtxvMXgqVD+tnbR
	IX5fQq1IjJUqJLcIHbBe879pSQChJtL2sQkG0Q==
X-Google-Smtp-Source: AGHT+IEVQgvulIjqQm258FjkM+m3ikdwhnUFuJgkTHBt8qMmT08fchzBbboDXtYublXIeoxrUzYy+qKRkBfsZGjDplk=
X-Received: by 2002:a05:6512:159d:b0:50b:e713:574d with SMTP id
 bp29-20020a056512159d00b0050be713574dmr2319296lfb.75.1701982759757; Thu, 07
 Dec 2023 12:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122235050.2966280-1-robh@kernel.org>
In-Reply-To: <20231122235050.2966280-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Dec 2023 14:59:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrpWoHxU1=FaCkJCg-E5G6JjudjsiUvv4cdQVyKM88KQ@mail.gmail.com>
Message-ID: <CAL_JsqKrpWoHxU1=FaCkJCg-E5G6JjudjsiUvv4cdQVyKM88KQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: Drop undocumented examples
To: Vinod Koul <vkoul@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:50=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> The compatibles "ti,omap-sdma" and "ti,dra7-dma-crossbar" aren't document=
ed
> by a schema which causes warnings:
>
> Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /exampl=
e-0/dma-controller@48000000: failed to match any schema with compatible: ['=
ti,omap-sdma']
> Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/=
dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-=
dma-crossbar']
>
> As no one has cared to fix them, just drop them.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/dma/dma-controller.yaml   | 15 ---------------
>  .../devicetree/bindings/dma/dma-router.yaml       | 11 -----------
>  2 files changed, 26 deletions(-)

Vinod, Can you pick this up please.

As pointed out, examples don't document anything. "ti,omap-sdma" is
not documented at all (though in use). "ti,dra7-dma-crossbar" is
documented in dma/ti-dma-crossbar.txt and there's still an example
there.

Rob

