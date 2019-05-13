Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCBF1BBE5
	for <lists+dmaengine@lfdr.de>; Mon, 13 May 2019 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfEMR07 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 May 2019 13:26:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34983 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbfEMR06 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 May 2019 13:26:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id n14so5601647otk.2;
        Mon, 13 May 2019 10:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKIMabYolh/CWr9ZVS4BaOdQjFc8s0quPHe3Wg+vCIE=;
        b=LG04bSMY0kJGmMiM1c40anvUp3JNMunQX/rEWHtSAetVf7ieIPN7pBoXeTugY7rzwR
         UO8qDoZGbkgSic56d4oIU8rWLFD2QsWfvcnxlcUU3597W2GmvmunO7GCzXpPWiR2Q05h
         E2L0FPZzAFZUKOItk5S9fpindkGQhu8wxvnS2n7v4nuXd9H9IkjN6i7ssKYndbm8gZ1x
         HN4zqGe5dE3zlCRQ5ac3fWMr/b8tLk+yi3sns81E5pKtDdoFmy4f2u9Y8ANiCuGkJp5T
         BJLMStIV9s0stTZvzgwL8GOqHJFkasCf9hyCdTD0OOumXHtmkg4BnMKBUwjr557UK7sI
         FiRg==
X-Gm-Message-State: APjAAAV7IvpvPtcy1Yv/FixeQ6y/nemUXTAvcsExLiOZ8MpLO/QYXRHm
        URVdlebkTtqRFEwSLTV+FA==
X-Google-Smtp-Source: APXvYqxyXc8m8ojecJr8JAPWWliXRCzCTj/jyi66UThIvubAV42LSZvfB+YZ9RO6ckrbWofzjD016Q==
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr16867947otq.197.1557768417211;
        Mon, 13 May 2019 10:26:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y129sm5567619oig.27.2019.05.13.10.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:26:56 -0700 (PDT)
Date:   Mon, 13 May 2019 12:26:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 08/14] dt-bindings: spi: imx: add new i.mx6ul
 compatible  name
Message-ID: <20190513172655.GA12061@bogus>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-9-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557249513-4903-9-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 7 May 2019 09:16:25 +0000, Robin Gong wrote:
> ERR009165 fixed from i.mx6ul, add its compatible name.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
