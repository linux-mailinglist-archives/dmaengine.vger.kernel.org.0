Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06783734D66
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFSIRo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 04:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFSIRn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 04:17:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034C110
        for <dmaengine@vger.kernel.org>; Mon, 19 Jun 2023 01:17:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f8d5262dc8so22540105e9.0
        for <dmaengine@vger.kernel.org>; Mon, 19 Jun 2023 01:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687162660; x=1689754660;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJ/7Kbo9gs7zs3QTF5nFKkJrBjocKGAtdax9LA/wsFg=;
        b=H+0E7pNp9pNZzhSLIjJvRVnOXXbI3e13G2NuiaL4Z5ksLG1VklHI5M6sJeJIyY6xdM
         cUGIRTVcFwr14+8x+ut4EXKAbRthMtsyth9RkKPsW+Ag720IIXKwY3mPFlVpMWq24DFK
         B1qyOPQcMy+vYna6qy3OHOl4oG1oFOfTik/U2Njh9DWZ47838GtsBc98V0Aw3OhzCPr0
         5YjfEc3B/5wMzXnvqYJbYJUvDOmygagBfHdfGofUr5Y2S9yyhpHi6XPBteeceJzx7SeN
         lsa7dgavhwc51iAjm/UPrM2gEEkDMu67dxskGSvOKbPhMB0LC/fTotZ6piG25Bhz1uIU
         FXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162660; x=1689754660;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJ/7Kbo9gs7zs3QTF5nFKkJrBjocKGAtdax9LA/wsFg=;
        b=gbxmOT7Y3yYFCxo0PpX9dUxzs3TzSTQ6S6vikhtKKtAJ5TBWnPZy0QurOvs6rtVoDA
         GoZv3/n/oagOWs+8cLxRMP3tRDiyNt1nQ0b+oUuDU+Tq9TCdEzvBCNuKttoK9h7eYFv4
         gL5g7Qygm4SRlveTuvWSfCfC/ZTkGsexmU5TmGr9DZV41E5NXNMCSdXDFntWcqlPBEyY
         gD8bBmIkZGUwjzHC2JrwJzorlGDGgtH3iXzxl7OjnBZfuhQwojmRqm7thRaGpLZKnO/H
         KMGKzgttzfusYFR5Qnshb9JAyZWcKCQoht29+As66PIHOEIQH9yK4kX0S+4p/7aNw+V/
         Q9/w==
X-Gm-Message-State: AC+VfDzEFmVuWplAJC70AqVPdPh0jLyjq7PJlDp6xiP0JkNyf+e5mYw9
        OQCnDIZBlSiZpTP5nx6GQmeLW6H31nVB90xWKA==
X-Google-Smtp-Source: ACHHUZ4xroxjb554vFvTZkEn5+JHpLoMlGFPbRAigQmrYdpVY3QU8OxUHNXVYdtEk8o5jyLAoD0ypxsEfe9SXsziyUU=
X-Received: by 2002:a1c:cc07:0:b0:3f7:c92:57a0 with SMTP id
 h7-20020a1ccc07000000b003f70c9257a0mr7418443wmb.14.1687162659986; Mon, 19 Jun
 2023 01:17:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:a093:b0:28c:2d96:d817 with HTTP; Mon, 19 Jun 2023
 01:17:38 -0700 (PDT)
From:   offer <carlos.charityfoundation102@gmail.com>
Date:   Sun, 18 Jun 2023 20:17:38 -1200
Message-ID: <CANef00XgbV60g9JNPDevg0F4pamPVwqqVDfaOzPdrJ7oQVGLrA@mail.gmail.com>
Subject: Greetings From Saudi Arabia
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear Sir,

Need funding for your project or your business ? We are looking for
foreign direct investment partners in any of the sectors stated below and we are
willing to provide financing for up to US$ ten Billion to corporate
bodies, companies, industries and entrepreneurs with profitable
business ideas and investment projects that can generate the required
ROI, so you can draw from this opportunity. We are currently providing
funds in any of the sectors stated below. Energy & Power,
construction, Agriculture, Acquisitions, Healthcare or Hospital, Real
Estate, Oil & Gas, IT, technology, transport, mining,marine
transportation and manufacturing, Education, hotels, etc. We are
willing to finance your projects. We have developed a new funding
method that does not take longer to receive funding from our
customers. If you are seriously pursuing Foreign Direct Investment or
Joint Venture for your projects in any of the sectors above or are you
seeking a Loan to expand your Business or seeking funds to finance
your business or project ? We are willing to fund your business and we
would like you to provide us with your comprehensive business plan for
our team of investment experts to review. Kindly contact me with below
email: yousefahmedalgosaibi@consultant.com

Regards
Mr. Yousef Ahmed
