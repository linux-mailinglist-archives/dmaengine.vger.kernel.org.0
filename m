Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E817C379115
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhEJOko (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245667AbhEJOid (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 May 2021 10:38:33 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F774C061238;
        Mon, 10 May 2021 07:00:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t20so7666071qtx.8;
        Mon, 10 May 2021 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=L/ovaQGsIQJ16RcBfR6b/a0uw1v8AuIn7fQ9eh4YsdSSKvDW4CkAjvTB/dGpjznghX
         L6lqqe+Kk27OTwdCf5fqsCSYKCCvyNzjzN9aiIHsKJHBeR7fNrjGs7yHW7aNgkvz0jj3
         2Hz07jB83RuuTOK0PhpCj+/L95e8wZN0INkyMFHz3yI1uGZ2iuQZ155bQk8hz5CDmYMy
         mAKvWtMz2MxKZfQB2ixw/N0ydujFB/OUGVn5AxrTTELxqskFotx9R2X0D47OMzDdM4rx
         o83MVzN0/LS6fc5WGdsq+8nmxXaXakboOJmLEvl4lKLaJYqdsf1toqitIi0UCwEU1TvF
         5mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=VIlCq8g19SysQ8JfhD4fTrtj8PMz8ZMM15Jy+3Bv6LrEGWBP5PYlT56bcci1gKiFTd
         tvPmXGt1z7pa5TNuIQLybEuhNF4G7XIIjObisF90lrIVGpV1W49staeDSMhG52LNFIQ0
         h7Waiip3fCU4IUiWD/Wx370nTzqaclFRWsQflAEOSVV25lAdoPlCsj6WCHPollcf6ofL
         69aOpuc3Fwh/k+Io80yQrsK6PKDi1zYzzVpZmRgBR4yselDpyz7Kqm8IRIJC2qbopF/i
         huLCnSVuw4FMNgWU55254qHUoJu4FmA8npp3vKTerloDwpfsd9ABDDbJzSc9nihh71V1
         hHtw==
X-Gm-Message-State: AOAM533uECgE81YC/TPMXyz/bw78hXT45DcHzwbpAT6PqWk4HsRbjo1L
        HTUjxyFmL0N7SoI3op/PzLZUrh1yIE8eYmdG9IqWzbBQRn0=
X-Google-Smtp-Source: ABdhPJwh5JX+bwkggx6HLDsx//+0oTOuuzpBvGpN6VQvRf6Z6sNFlcsbQacasqJW84jKbyHf62u2uu3iQdIRPdfCXYY=
X-Received: by 2002:ac8:6a01:: with SMTP id t1mr19600561qtr.47.1620655250595;
 Mon, 10 May 2021 07:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org> <20210505213731.538612-17-bhupesh.sharma@linaro.org>
In-Reply-To: <20210505213731.538612-17-bhupesh.sharma@linaro.org>
From:   Rafael Reinoldes <rafareino@gmail.com>
Date:   Mon, 10 May 2021 10:58:49 -0300
Message-ID: <CAOZB5GH1r+T9xMuO9vi-R_h_T5q0jvOZ2As0MUeESPxM1MHcLw@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] crypto: qce: Defer probe in case interconnect is
 not yet initialized
To:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

unsubscribe
