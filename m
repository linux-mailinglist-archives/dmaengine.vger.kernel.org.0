Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AB44DE1A2
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 20:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiCRTOk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCRTOj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 15:14:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F95ECB22
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 12:13:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r10so12958981wrp.3
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=hJ6vnRkGqf7o3va/KYBtaxPfYuk6B8FxppLseSIcVuI=;
        b=QXkkQzxp8uF9oqHcQhVgymindkVI3niavHhKjoWiD7EZ08iPPv14t7+stMT+UwCqPk
         r+M7gO+to05fgvVe5PoZqDxcaEKkFy/lV1zHMG7xkQTVhvjYStdusEJ8/w9P5dgvTjMh
         wBGw3zfDK5xdV2e8DliH7PE9gKVKjyLU28QJehmcKbhzRy/X7dIgzQflk4Ycu5cobfzC
         nM722fIBpXK0+ZJUy3/b8TUqgIEdnLdNn4m6yryixyqGKCCDA2rLiIvrQybc5VGtHYyM
         nZ9u6nd6sZw6QIqfQ3wie4u/OCxlqMW7gqnnVVZnlQEByAxgc4ljdYZ3y8JqZq+9IAVv
         te6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=hJ6vnRkGqf7o3va/KYBtaxPfYuk6B8FxppLseSIcVuI=;
        b=6+kitke9W/QcZBRtAnONx7yiln9BUfqBZvcHtCkqerUHblotmf5ULeeDAxFcp2Oxbi
         qUXV3nlfUmB9rst46b7BcfHLHsIQxrSJg4JC/GpR647fAPUSJv+EUOZrTa9VPth6K5Qc
         GBu/b+qiN52cB2R2x3YVbTCdsF60OMAklz5yuIyjW682i/mLNv1zhroX4PDsooZScsvc
         p7c5WsUL2Ar92s/4MoOY0NzKZpdZyVvAsIMKwgB5pEjnEZNEsFAzYoeeTX9RI4LSsw8n
         JIkXw5tiXTbFwoJcZZlzKaG8zsAN91MftAOUOIIPad6KEPci7M2edO3IYUylTDLo1P0Z
         72dA==
X-Gm-Message-State: AOAM532cNXQ3CuF0qJ+ep4dhz5gdPYBf8pF+OE+BZU2x5KcWF2LF0t3H
        rVkRRK0JFDq6KW8ax8QxKA==
X-Google-Smtp-Source: ABdhPJxAhC4eEBLGpBHOK7crL17eVFw4CNa4/Ch4c1mSYEdq9JfNi0FUgFEdINGl0Qcyn1WX5sk35g==
X-Received: by 2002:adf:ee0d:0:b0:203:d8d8:2183 with SMTP id y13-20020adfee0d000000b00203d8d82183mr9230082wrn.303.1647630797987;
        Fri, 18 Mar 2022 12:13:17 -0700 (PDT)
Received: from [192.168.43.30] ([197.211.61.62])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d64cc000000b00203d01e1075sm7635787wri.50.2022.03.18.12.13.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 18 Mar 2022 12:13:17 -0700 (PDT)
Message-ID: <6234d9cd.1c69fb81.59376.e036@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: meine Spende
To:     abdullahijigawa202020@gmail.com
From:   abdullahijigawa202020@gmail.com
Date:   Fri, 18 Mar 2022 12:13:08 -0700
Reply-To: mariaelisabethschaeffler702@gmail.com
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42a listed in]
        [list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [197.211.61.62 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5017]
        *  1.5 RCVD_IN_SORBS_WEB RBL: SORBS: sender is an abusable web server
        *      [197.211.61.62 listed in dnsbl.sorbs.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mariaelisabethschaeffler702[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abdullahijigawa202020[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abdullahijigawa202020[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich erfahren

https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria Elisabeth Schaeffler
E-Mail: mariaelisabethschaeffler702@gmail.com
