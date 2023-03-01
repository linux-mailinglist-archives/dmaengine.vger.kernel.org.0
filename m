Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13E6A720B
	for <lists+dmaengine@lfdr.de>; Wed,  1 Mar 2023 18:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCAR2S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 12:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCAR2R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 12:28:17 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B37F61B9;
        Wed,  1 Mar 2023 09:28:12 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id s26so56774498edw.11;
        Wed, 01 Mar 2023 09:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gulWVH/sPIU6yOCZNhy1ilRLX8pmCKNR1YsylU0tXqg=;
        b=MY2ha1FCla4JB/Wvo5yDX5+a5sR1M2PfNbPuMfm1zLo9DxFq3w1npu0wm2wnqNabif
         hf+dwv6sXF0/DyiSchrpgQERJMmpp/PpEku/N8oI1GsWbAPUAzqQmlDUEVtfeKhH0F+5
         ohLl61Y5qwKxAz+fZPpwcttfd/OeZ+5YmwjUQfXfaOhsOvJLI7yDJurXTGgbZ0c25gxB
         OiiyqJGLEm+JtW+K1qskQHLHVlo6V6dXzln7XkTVpcBhku/s5ROTPQlVkZ+h9SpXo3SI
         Td6dIJZ7vBBlQ/TCvfZNLQOyKgAOcesmfkRMzcun4wrRFJ0Ao/3kirvlL6xCX4MksC/X
         99kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gulWVH/sPIU6yOCZNhy1ilRLX8pmCKNR1YsylU0tXqg=;
        b=n0ilRbiY4dNahOQb3j1hxQhG/yBbR9z3jP2qSyPfahRB/7J7gbnrDqufTkxJCqweg8
         kJlCkIoVdLdHmBo0LcRvy3pH0dZr7Fkiypko3/iSJmM50ygPbkFfbvfYlOOSUZe+62/o
         MgQ5VdGgfgfYDPkHFVmO5e4Cm/RaIEcL9MQ+9N9CvNAvZsWSyBxDmqihiVcbikFn0Mj3
         pYv6FT4j3PrS48Zn9SO3MKQm0DXK2oPxclKeTdS/FENtCkxXQbVaGnp0SmE4HsANexdd
         khZr48Zyws64ouy43Axgf4z5R5EvPXSj/lgt/bRoITBpHcrLE2s6VTm+UUiJnH7Qz08B
         Wc1Q==
X-Gm-Message-State: AO0yUKXQQCZraYogbhyFrkGhvzoENox8RQq0rVx9JodjHa67sc9H66S6
        o/tE/+7ATN1A1vwIu99JpFY=
X-Google-Smtp-Source: AK7set/oP8YcQpwI4E3owCU87g+/OfqHNU5T/spkclqiEAS8Llf4/XCGUSo56vD3xah0+tfmftjYuQ==
X-Received: by 2002:a05:6402:1117:b0:4ad:7224:ce94 with SMTP id u23-20020a056402111700b004ad7224ce94mr8780777edv.15.1677691691044;
        Wed, 01 Mar 2023 09:28:11 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id k12-20020a508acc000000b004af71e8cc3dsm5851023edk.60.2023.03.01.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:28:10 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Wed, 01 Mar 2023 18:28:06 +0100
Subject: [PATCH] dmaengine: ppc4xx: Avoid returning iterator in
 ppc440spe_get_group_entry()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230301-dmaengine-ppc4xx-avoid-iter-after-loop-v1-1-330689e1e6fd@gmail.com>
X-B4-Tracking: v=1; b=H4sIACWL/2MC/x2OwQrDIBBEfyXsuQvGhFD6K6WHVddkoVHREoSQf
 4/2MvCY4TEnFM7CBV7DCZkPKRJDg/ExgN0orIziGoNWelKTGtHtxGGVwJiSnWtFOqI4lB9nJN/
 zG2NC/VyU0WYhP4/QZIYKo8kU7NZ1O5U27UXK7KX+H7w/13UDoTtxYZEAAAA=
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677691690; l=1271;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=SYwttO2B0dATcsw8vkVCVRiW0EC92ynoBMVqWDILQOw=;
 b=L/YvdY4EBghRKSRVN+Llho0v4AnJD+stIr5hKidmbjspFs51fe/LMlv09llbCTNYOqI1DIUEgJC5
 SpvbOYmbCfDwlUoqiaXNhAEjklxa5VfKS9R0VtBgcZ9jvJsiVW0S
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Linus proposed to avoid any use of the list iterator variable after the
loop, in the attempt to move the list iterator variable declaration into
the marcro to avoid any potential misuse after the loop [1].

Instead we'll just return 'iter' within the iterator and otherwise NULL.
This ensures there is never a bogus pointer returned (e.g. if the list
is empty).

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 drivers/dma/ppc4xx/adma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 686c270ef710..f62f9653196f 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -1431,9 +1431,9 @@ ppc440spe_get_group_entry(struct ppc440spe_adma_desc_slot *tdesc, u32 entry_idx)
 
 	list_for_each_entry(iter, &tdesc->group_list, chain_node) {
 		if (i++ == entry_idx)
-			break;
+			return iter;
 	}
-	return iter;
+	return NULL;
 }
 
 /**

---
base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
change-id: 20230301-dmaengine-ppc4xx-avoid-iter-after-loop-2860b2b6af41

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

