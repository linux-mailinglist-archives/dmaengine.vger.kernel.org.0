Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29AF7180712
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 19:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCJSlH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 14:41:07 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35586 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSlH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Mar 2020 14:41:07 -0400
Received: by mail-ot1-f43.google.com with SMTP id k26so6947064otr.2;
        Tue, 10 Mar 2020 11:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PQABEcEk14Djn/LTjb5Ace2N+AY5AMQXCZutVyQXiUs=;
        b=ukiSN6A3P2avIco+2SYJf+QS34JEcdWNnWES82FFSuwlh19xM+xe+sgDx2HI4pjocX
         MwPmoktmbD6visqO1dVIl0O1XdYZUxaSp+Ortc9fPBghuhG01U8nfI1NESZpKPtcGKNM
         pC0jrCg/qQYIn8I16s7yzy2ZqlK6gsL7qZat1eAEGzFqK/nk+po58Z3+LN6ds+zuHFXi
         pWT8zC2guomWpnD7iq3u15P2P7VL9OQ1L+Wv5usSJ7bNB8nb4/YWEWtVM3XIxHLS0INq
         cXmkiD2SHlQz1YG8Nr5FJWzuybl4DUVdpefKggv/AJATLKUJegtxXSsPEvCvN43HnxNW
         8d1g==
X-Gm-Message-State: ANhLgQ0KArhO1IIZyPOWpnX9aJRcNFTPdDAf91uYlPNNHX97Jwu3KZdg
        xvUwE5+0HS5Jw/aTdvE/aQ==
X-Google-Smtp-Source: ADFU+vuCpy55+wQ03dvYMG8T9a9Ha2z5esUQgxNizO1+WBHUPrvJ7vapbxm/UI4ejAFS/eHYpZMrxg==
X-Received: by 2002:a9d:67c7:: with SMTP id c7mr3275865otn.85.1583865665110;
        Tue, 10 Mar 2020 11:41:05 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s128sm4496355oia.4.2020.03.10.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:41:04 -0700 (PDT)
Received: (nullmailer pid 2384 invoked by uid 1000);
        Tue, 10 Mar 2020 18:41:03 -0000
Date:   Tue, 10 Mar 2020 13:41:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND v6  08/13] spi: imx: add new i.mx6ul compatible name in
 binding doc
Message-ID: <20200310184103.GA2192@bogus>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-9-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583839922-22699-9-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 10 Mar 2020 19:31:57 +0800, Robin Gong wrote:
> ERR009165 fixed from i.mx6ul, add its compatible name in binding doc.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
