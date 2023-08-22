Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C71784CB8
	for <lists+dmaengine@lfdr.de>; Wed, 23 Aug 2023 00:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjHVWM1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Aug 2023 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjHVWM0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Aug 2023 18:12:26 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 15:12:23 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D179DCF
        for <dmaengine@vger.kernel.org>; Tue, 22 Aug 2023 15:12:23 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-86-64e51a58eb0a
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 8B.B2.10987.95A15E46; Wed, 23 Aug 2023 01:28:09 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=Cl/PpsadmHd/zAhReHwI14zvJjQTaxdlqgIkev35OtaYNYws3FXOf/Mc2WS/dqgsu
          q2iwo42yNOGfRsZaFgm5sCLLdI+Mc+a4Ae2YUjfQwGx7sbCv62bC44OcM4KfO71fQ
          4ajgA5Ly/8SQnjt7U3oVkJxPhR6SxcH0FMv623Nuk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=lPdzcb2HL3PIBOyZjuKPrTeRan7zJzEuaNyfqpHlEBq8zAi7d52+AjI6G4efWun53
          BmawbLUTlvKEbLxfVpfYLTlFy/zcUTlfFJE9EEK42r+FSxGWttR739HG4m0955/5z
          vMTVMNAFTPcbalbppI8kh7achkohew7wY9WrKDNWI=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 01:20:19 +0500
Message-ID: <8B.B2.10987.95A15E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     dmaengine@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 13:20:33 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGWzdS6mmKweu9/Barp/5ldWD0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OCQEDCRWNvg2cXIySEksIdJ
        4vJmsy5GLg4WgdXMEje39jFCOA+ZJeacnsUG4ggJNDNKfO65zQLSwitgLXH/xW5WEJtZQE/i
        xtQpbBBxQYmTM5+wQMS1JZYtfM0Mso1ZQE3ia1cJSFhYQEzi07Rl7CC2iICsxM3va8Fa2QT0
        JVZ8bWYEsVkEVCVudFxgh7hOSmLjlfVsExj5ZyHZNgvJtllIts1C2LaAkWUVo0RxZW4iMNCS
        TfSS83OLE0uK9fJSS/QKsjcxAoPwdI2m3A7GpZcSDzEKcDAq8fD+XPckRYg1sQyo6xCjBAez
        kgiv9PeHKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5bYWeJQsJpCeWpGanphakFsFkmTg4pRoY
        tbe8fbv374avTfd7ZBZK8b57ZuKt7Jdyd/r11ZsnJTUm3Yz0uHJ747F7Fr1zq8s2zz0V2KKo
        PZfh42ShwNjEhKcqny+t/O4o4/hgv06x0USTVWaRzr8OrmO7kPnK7e3Rj4u/pm78uCb3751t
        abwSBTcf9G+cO3GNaplsSemWXF6NVRF87VbNE5VYijMSDbWYi4oTAVgihrc+AgAA
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

