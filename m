Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7467F552E6E
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349002AbiFUJeo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jun 2022 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348991AbiFUJen (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jun 2022 05:34:43 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103125E84
        for <dmaengine@vger.kernel.org>; Tue, 21 Jun 2022 02:34:42 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v81so23523075ybe.0
        for <dmaengine@vger.kernel.org>; Tue, 21 Jun 2022 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=h4kelL6+9X0di90BJF8jjkbQ67xu6yQ9Psym56sNHhds6TqYrUs59qFfMJJ/8GOmSO
         32XnHIVZkfh+zFzP7DLGbFHkZPFcB+8qdYI5Asio/29v9xKd6uay+TeI5YmEWlLoTE78
         8Zn6n424q0JAoenlQI5EUoyrPS1H3itz6Cx5GATIQaSkuoqNSPsr/6wucUYKi+U+VVQV
         gQpENi5EFbZMwbBrNL8uM7S1LREmWTS5MdkJtRIwjmIZDAStTKKAXe21VZOy+Ce/24ws
         paswcJs2ZEC1kAoVQyJbSAhbrDSsbmpFUrYPSVzWB9+X6ATfwxTFbxXtt9dDxah5BUiR
         brrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=QluqZqBu52IjRLczwGA5cDGSeRfP5LygGhd8sjK0uOBVRO595tGwYWiab6+s9jIQ9q
         z0jVRLDvmUhW8JJ0+c8Nj9k/tqcrYk5bNiBcQyJLZOVJAb5aO+EWKInEjxdhH8skdZEO
         BT5ctE/RuZ4nXMYIeuo5ckCqrg8ih6G/Ai000CYLkTkjXrWiE2gysABi/UVmTMOmYyGS
         cWL7+hEZA87CiArAGF9J0TJjnRll8r5Iza8lnEFlD5rrqY8kynCb88OuwhzyHUZbUFuH
         H+nUiY6q9h7mqjcc3+ZmMnxozxIBCzvh/pLR6MGuEzxUNPuZUyyuvcT5E1aF2h6qQCnj
         Qz1g==
X-Gm-Message-State: AJIora/254+2pUlEJGallWSXXhyPPTk3NVUXRn1XLAZBdpDXJkoBQb40
        arcl+E7sNzpg8ulJE/rKLq/qc27kgRVVBHiV/7k=
X-Google-Smtp-Source: AGRyM1tkFnKoLbDgMnjySy0ErBZpnfjHPfaFKKtSsCxRLgRIKk5bXYNuLJz2vI6RF3anVmPuYfwLxHJ/RTqRlVM2SK4=
X-Received: by 2002:a25:9bc4:0:b0:669:5116:533b with SMTP id
 w4-20020a259bc4000000b006695116533bmr2049327ybo.537.1655804081508; Tue, 21
 Jun 2022 02:34:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:e10a:b0:2d9:e631:94d0 with HTTP; Tue, 21 Jun 2022
 02:34:40 -0700 (PDT)
Reply-To: dimitryedik@gmail.com
From:   Dimitry Edik <lsbthdwrds@gmail.com>
Date:   Tue, 21 Jun 2022 02:34:40 -0700
Message-ID: <CAGrL05Zv58OMJWkZLfQaQneEMMcXm4F75v=N5LH8YYBTe1yQvQ@mail.gmail.com>
Subject: Dear Partner,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lsbthdwrds[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Dear,

My Name is Dimitry Edik from Russia A special assistance to my Russia
boss who deals in oil import and export He was killed by the Ukraine
soldiers at the border side. He supplied
oil to the Philippines company and he was paid over 90 per cent of the
transaction and the remaining $18.6 Million dollars have been paid into a
Taiwan bank in the Philippines..i want a partner that will assist me
with the claims. Is a (DEAL ) 40% for you and 60% for me
I have all information for the claims.
Kindly read and reply to me back is 100 per cent risk-free

Yours Sincerely
Dimitry Edik
