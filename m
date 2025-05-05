Return-Path: <dmaengine+bounces-5053-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7FAA93FC
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6379C1899DF9
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615614AD0D;
	Mon,  5 May 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRPhLn05"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58992561DC
	for <dmaengine@vger.kernel.org>; Mon,  5 May 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450388; cv=none; b=gYlq8uUH1Krk7SG0opxGZ/wpPiW7TEX9gmmzZy/OSh5ENNFKbCvHzDCQX8060wO1Yd+yLwcN5jBeSLwErplr14cAnA4NCP4vspDGAO/nAZcYwHh3ZTKg3fcKBX4V18/1ZPGwEBjtcWm+9T8vmhheKVJCSmkEazO2Fur1mIpK/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450388; c=relaxed/simple;
	bh=cwiOX6cmqTQzmk3WggAwoK4SaoNLnnEpCnVxHf6Qxmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0cWwfcx8Bac56eUEVyv9lLJuayKHLlXlHKfEPW45KnmklEjdG1Ra6PqV8lth95Gmo9sy2vyXrAvLPqewE0WdciiCp0TxnAmi/bjQhtIGgo6orJzYn+dRZQsJTSKv4c0vAhGO/zDelZexsQVbfIVIPqKHH/nViMhajNH4YyuE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dRPhLn05; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac345bd8e13so727792766b.0
        for <dmaengine@vger.kernel.org>; Mon, 05 May 2025 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746450384; x=1747055184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7djaZKuQTg8ZH962YLQL/FSVR3ehnU/TnBc6a+PC3fk=;
        b=dRPhLn05MBGi95i67XENDGk2MH4G/uDxTr7KnnnoSg3X0PFhjRFwc+16E1oYjPdKLn
         NSpFpaQeCDBGArug/m9CV+GJl+aM4kagEKakmfp0UttzmOE1hADfKck5ZY4zzPlzB5iN
         VyzVETnoFlG4j6bUB0oIyTMpEowmjLLwojxS10vgco0MNlk78eUjtg8wB+M8+r4oqndp
         SSmrZtjVuHhnGdIMLAk7u0vyHLjX/FybqVg8XF1oUYu3sZspVP9e27rLjhvf9Y3Dz+Rs
         M8ZZcewWRv5f0nJdHPTDA1B4vZmeiXFKRE0Ca8XSOlofzNWdTv/Nc7VWHgWbmXmOmFPn
         Ylzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746450384; x=1747055184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7djaZKuQTg8ZH962YLQL/FSVR3ehnU/TnBc6a+PC3fk=;
        b=oovRKvadSWhroOQittncyJltMU7+MX9VESBy2eCqQq1K6QvthE/FwEDajv78gWGu0/
         0m2uY4Lg19y2V0X/cNOeLl3YJm3K/9/dvO/7i6054aGWMWBYhsw2kJxt3F+4F+P1u9Pa
         j5scUgqNyS8Yahv6wxpy6AFKTyWG9MuTw+b1KzGkIBL3Nz5r8ctkLwVzG0zRs55UWVtL
         /NbJAoqXK2hgVv+1ngCjV/uo6wKm32eVpq0fbpfyops8Kfw+eUoEVoQu9PC4pCmmT2d4
         dtPOO/dUg9wLqTfZxZpNngdACIaT+YZlHE4w5Sq3rPwmcT60LIAKOUS+yYjR+AgDjMNo
         l8vA==
X-Forwarded-Encrypted: i=1; AJvYcCW2OSP+Zrun3IvoYf6JJoZYHS85W2j/oFmO+jIoiC2LDOzsdnXMW6UjvPBNY047YtQnjsVWx8B4hvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35xOo3TTKLkDGEk3A3cvffBl361wAzMzNoDdPlRVYME26kU28
	QWbDPujMYSudwryfSQN93/RKwnYPBZ2vPNtqNhKDXdUK4Bfp1+KPGH5qpyGqw08=
X-Gm-Gg: ASbGncvqVyhqCVI6JLoYgJ0G5rl61SWKf9BMoidZMTK37MRbFEidn7TA2mpg3tSA3lC
	IiHCQrcmGVIWbvS3uvoazpV8YtMvokj3JhLX++Jon+fagtPUtxvOeGKFXTCykYPu7K/LDfa8HiU
	tE5O/xs2UK0IaRnkdoM90xyztts4oBaPBKDMyvnTKNqtOTM9YCRcLWwOQyVkfmCFcxFxd79cNyi
	NTMNL+91O8KFv9XeW7FxRZfBIP8E+AB4kiHmT8aHuVMxAmXrTKHmuRTOk4srygKNhd0qHUHVW8G
	4/7t/jUK0VGoQzD0EsH4WGRHI7+FxguWlHQc+6avELR/V9gHGNMK
X-Google-Smtp-Source: AGHT+IHfBz0qV3tN9vwCFJbP2NAyCooPjwrUmB9tNTrYi+DjMO5kp0iNYUW/DW+NaeO6h2If04tIVw==
X-Received: by 2002:a17:906:6a12:b0:ace:caff:675a with SMTP id a640c23a62f3a-ad1905d7cdemr906825766b.10.1746450383927;
        Mon, 05 May 2025 06:06:23 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:c917:a6e9:5bff:a8c2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad18914d067sm491199666b.3.2025.05.05.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 06:06:23 -0700 (PDT)
Date: Mon, 5 May 2025 15:06:18 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: keep remotely controlled units
 on during boot
Message-ID: <aBi3ykEK5HG2WDD6@linaro.org>
References: <20250503-bam-dma-reset-v1-1-266b6cecb844@oss.qualcomm.com>
 <aBh9WL2OMjTqBJch@linaro.org>
 <aw6tjh5q6t75bif4jyusrdvroq53lbwlljo5cdgzrofn3a4loz@ixuu3yw4ucil>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aw6tjh5q6t75bif4jyusrdvroq53lbwlljo5cdgzrofn3a4loz@ixuu3yw4ucil>

On Mon, May 05, 2025 at 03:17:00PM +0300, Dmitry Baryshkov wrote:
> On Mon, May 05, 2025 at 10:56:56AM +0200, Stephan Gerhold wrote:
> > On Sat, May 03, 2025 at 03:41:43AM +0300, Dmitry Baryshkov wrote:
> > > The commit 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM
> > > underflow") made sure the BAM DMA device gets suspended, disabling the
> > > bam_clk. However for remotely controlled BAM DMA devices the clock might
> > > be disabled prematurely (e.g. in case of the earlycon this frequently
> > > happens before UART driver is able to probe), which causes device reset.
> > > 
> > > Use sync_state callback to ensure that bam_clk stays on until all users
> > > are probed (and are able to vote upon corresponding clocks).
> > > 
> > > Fixes: 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM underflow")
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > Thanks for the patch! I actually created almost the same patch on
> > Friday, after struggling with this issue on DB410c when trying to add
> > the MPM as wakeup-parent for GPIOs. :-)
> > 
> > How is this issue related to _remotely-controlled_ BAMs?
> 
> My understanding is that for locally controlled BAMs we can disable the
> clock at the probe time as all the users of the BAM will be probed
> before accessing the BAM. In case of a remotely controlled BAM there can
> be a user (e.g. UART) which is running, but didn't request DMA channel
> yet.
> 
> Please correct me if I'm wrong here.
> 

Yes, I think there is a misunderstanding:

 - UART doesn't use DMA for earlycon (and I'm not aware of any boot
   firmware using DMA for UART either). The bam_dma driver really works
   as intended here, it votes for the clock during probe to perform the
   register access, then it drops the vote when going to runtime
   suspend. We don't really need .sync_state() for the BAM, because
   there are no active DMA consumers during boot.

 - All of the BLSP peripherals (BAM DMA, UART, I2C, SPI) need the
   shared GCC_BLSP1_AHB_CLK for register access. What happens is:

   1. GCC_BLSP1_AHB_CLK is left running by the bootloader.
   2. earlycon makes use the UART registers (without DMA), but doesn't
      vote for the clock (also: the clock driver isn't probed yet).
   3. GCC driver probes, leaves GCC_BLSP1_AHB_CLK running since unused
      clock cleanup happens later.
   4. bam_dma probes, requests GCC_BLSP1_AHB_CLK, votes for enable to
      access registers during probe.
   5. bam_dma goes to runtime suspend. The last (known) consumer of
      GCC_BLSP1_AHB_CLK is gone, so the clock is disabled.
   6. earlycon continues accessing the UART registers.
   [Device reset]
   7. The full UART driver probes and votes for GCC_BLSP1_AHB_CLK.

Conceptionally, we don't need .sync_state for the BAM, we need some kind
of .sync_state for the GCC_BLSP1_AHB_CLK. Or we need earlycon to vote
for the UART clocks as soon as the clock driver probes. Which is roughly
what drivers/clk/imx/clk.c imx_register_uart_clocks() does, except that
releasing the vote on late_initcall_sync() could still be too early.
(It's a stupid configuration, but what if UART needs some modules to
 probe successfully?)

> > The BAM clock will get disabled for all types of BAM control, so I don't
> > think the type of BAM control plays any role here. The BLSP DMA instance
> > that would most likely interfere with UART earlycon is
> > controlled-remotely on some SoCs (e.g. MSM8916), but currently not all
> > of them (e.g. MSM8974, IPQ8074, IPQ9574, ...).
> 
> This probably means that the definition of the flag needs to be
> clarified and maybe some of those platforms should use it.
> 

Yeah, probably. It would require testing and/or checking downstream
sources though. Here is a slightly clearer definition for the flags:

 - Controlled-remotely = reset+initialized outside of Linux, skip reset
   and initialization of global BAM registers.
 - Powered-remotely = powered on outside of Linux, but global BAM
   registers must be reset and initialized inside Linux.

And for the clock:

 - Clock specified: We can vote for the BAM to power on by turning on
   the clock. After that, we can access registers during probe.
 - Clock missing: BAM power management is integrated into the consumer
   interface (e.g. SLIMbus, BAM DMUX). We cannot access registers until
   the consumer requests the DMA channel.

I think the BLSP DMA (for UART/I2C/SPI) is often "controlled-remotely",
because there is the option to use some of the instances inside one of
the remoteprocs (RPM/Modem/WCNSS/ADSP/etc). It's not our job to keep the
BAM on though, the GCC_BLSP1_AHB_CLK is a clock that every remoteproc
can vote for independently.

> > The fixes tag also doesn't look correct to me, since commit 0ac9c3dd0d6f
> > ("dmaengine: qcom: bam_dma: fix runtime PM underflow") only changed the
> > behavior for BAMs with "if (!bdev->bamclk)". This applies to some/most
> > remotely-controlled BAMs, but the issue we have here occurs only because
> > we do have a clock and cause it to get disabled prematurely.
> 
> Well... It is a commit which broke earlycon on on db410c.
> 

FWIW, earlycon works for me on 6.15-rc4 on DB410c, I've only run into
this issue after adding the MPM definition, which changes probe order
enough to trigger this issue. I'm not sure how that commit changes
anything, will try reverting it for my setup later to see what happens.

> I started to describe here the usecase of the remotely-controlled DMA
> controller being used by the BLSP and then I understood, that I myself
> don't completely understand if the issue is because DMA block is
> controlled remotely (and we should not be disabling it because the BLSP
> still attempts to use it) or if it's a simple case of the clock being
> shared between several consumers and one of the consumers shutting it
> down before other running consumers had a chance to vote on it.
> 

The latter, as explained above. The DMA block doesn't play any role
here, it's not used during boot.

> > Checking for if (bdev->bamclk) would probably make more sense. In my
> > patch I did it just unconditionally, because runtime PM is currently
> > a no-op for BAMs without clock anyway.
> 
> Please share your patch.
> 

It's more or less equivalent to yours with some if checks removed.
I would be in favor of leaving the bam_dma driver as-is and solving this
on the clock/earlycon level.

> > 
> > I think it's also worth noting in the commit message that this is sort
> > of a stop-gap solution. The root problem is that the earlycon code
> > doesn't claim the clock while active. Any of the drivers that consume
> > this shared clock could trigger the issue, I had to fix a similar issue
> > in the spi-qup driver before in commit 0c331fd1dccf ("spi: qup: Request
> > DMA before enabling clocks"). On some SoCs (e.g. MSM8974), we have
> > "dmas" currently only on &blsp2_i2c5, so the UART controller wouldn't
> > even be considered as consumer to wait for before calling the bam_dma
> > .sync_state.
> > 
> > It may be more reliable to implement something like in
> > drivers/clk/imx/clk.c imx_register_uart_clocks(), which tries to claim
> > only the actually used UART clocks until late_initcall_sync(). That
> > would at least make it independent from individual drivers, but assumes
> > the UART driver can actually probe before late_initcall_sync() ...
> > Most of this code is generic though, so perhaps releasing the clocks
> > could be hooked up somewhere generic, when earlycon exits ...?
> 
> The spi-qup commit looks like another stop-gap workaround. Let's add CCF
> and serial maintainers to the discussion with the hope of finding some
> generic solution.
> 
> Most likely the easiest solution for Qualcomm platforms is to add
> additional vote on earlycon clocks and then to try to generalise that.
> 

Yeah, that would be the best option I think.

Thanks,
Stephan

