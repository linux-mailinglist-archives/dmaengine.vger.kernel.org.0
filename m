Return-Path: <dmaengine+bounces-1348-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B68879A74
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629731F237A5
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D8137C41;
	Tue, 12 Mar 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlEAcRjm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7C137C3A;
	Tue, 12 Mar 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263791; cv=none; b=ExvxB2RhcgKfkRloXIVh2X5mcx8KmHeKzXmNqBUz7xBYxC+Io5dwNIhRt3VJok5rsz9Vns6TdhiHtwjBfX1OzlPU9V132Q6NIkBA9mgOM3zt3gNgRdm1LbNXIyl3HInMNMHkjtA0nmAzZJCSAJnY1Bs6OjxhQZ392Iw8qlIZKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263791; c=relaxed/simple;
	bh=rPV9UAMTT7Ev6dbXP0tzT2Ihl2UZVAIbIAO0GoplBK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hvh022jBFsuvXcFs4RKQTOq6Jvgf2dqTDJ1IoAEazFEVc6LZxt1qokccu0abYVHedU6fI6IN0JE56K1uvGfoZBkH1Vd6kXF2P6TMBVQJ7MLzu/HHP2jPk0r9cTNI4ivXi/MkknSfaQMFtRbLE+lrhrENHhCf1AVyCE3OKnqlkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlEAcRjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F81AC433C7;
	Tue, 12 Mar 2024 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710263791;
	bh=rPV9UAMTT7Ev6dbXP0tzT2Ihl2UZVAIbIAO0GoplBK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WlEAcRjmZxJAju3Lx0UUVcu9+yvCCp0OU4aQ7MWR0By1SqUfnYvtlWE2SEdCdyjjJ
	 4SoKsYovdKRLwtGoCCOz/xfTWFPt2LR+CHS1onVzpOfF56/gsEryEAV+ffGwqKSUJ5
	 3+4i2/foO7B/8Spe1XS0mUJz/TmoihO4JkESr/H+1MJuxTp7eQFUArfL8mnRIp5yUN
	 CUXw+V14biVc/vQPkPluiD8M/QbL8zpB057iRS/yGXef/eLwNZpf1L4iyHf2mQ1XKS
	 v6j+5IFbJf99aHRS6668uaJD7waQwF82C6pttASwKDcf7yv4vSGaXe3z6xtQNMv1zS
	 ie7FWiauV3jDA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513c53ed3d8so145399e87.3;
        Tue, 12 Mar 2024 10:16:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjODPyhoIl6lTNVtpMhxbp0bjlAcN2B9py50cW0Tmab+V8zpEgTVIIKGWD7DYiLowjfm5axj6sji2jvZOXCHktSldu89Q2MB0YIBPgk+F4SaU4tbxrKV63dWIaICnCFOAB+fKNwjseDZ9uUYXHbgeosXUBF4Wq43VVRUFNNZ6rE6WctQ==
X-Gm-Message-State: AOJu0Yy4savlhKJfRMbKaB7cjrUAcBrf4wizjsy+n0Vu/9Qh0ReTlBe8
	atB/8N/nsuV54bft0QgUnEQbZ94i0fa1Do/ATWSRsasjGm8M0BMmjUSv0A2s20n30zCQw/+Te1K
	n8qvHEpHkKKNMxAn4Nh0+df9Adw==
X-Google-Smtp-Source: AGHT+IEXIS/hqNSsPX7LypAcOpNcLKUmXgrpJs3soOu3wkkOFaYnmI/1uJiLAg5A24/EcKhYH7vjPIuj9vbUKQFxQPg=
X-Received: by 2002:ac2:5f8e:0:b0:513:c625:a6f6 with SMTP id
 r14-20020ac25f8e000000b00513c625a6f6mr414611lfe.49.1710263789456; Tue, 12 Mar
 2024 10:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311222522.1939951-1-robh@kernel.org> <171025134347.2083269.1302794772701834117.robh@kernel.org>
 <ZfB1s2Vy8lXCSLme@smile.fi.intel.com>
In-Reply-To: <ZfB1s2Vy8lXCSLme@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Mar 2024 11:16:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJZmMAqZEo6+12FZn6-ALCaYquPHd5EdZSW6u0Z2m+jg@mail.gmail.com>
Message-ID: <CAL_JsqKJZmMAqZEo6+12FZn6-ALCaYquPHd5EdZSW6u0Z2m+jg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width schema
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Viresh Kumar <vireshk@kernel.org>, 
	devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:33=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Mar 12, 2024 at 07:49:05AM -0600, Rob Herring wrote:
> > On Mon, 11 Mar 2024 16:25:22 -0600, Rob Herring wrote:
>
> ...
>
> > My bot found errors
>
> Well done! :-)

Thanks. I was testing locally with some pending dtschema changes while
the bot uses the current 'main' branch.

A 'minItems: 1' here should fix this, but I need to look into why the
current schema doesn't have that problem. I wouldn't expect a
difference.

Rob

